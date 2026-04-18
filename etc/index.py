#!/usr/bin/env python3

import os
import time
from pathlib import Path
import urllib.parse

ROOT_DIR = Path.cwd()
EXCLUDE_DIRS = {'.git', '.github'}
EXCLUDE_FILES = {'index.html', 'generate_indexes.py'}

def format_time(mtime):
    return time.strftime("%d-%b-%Y %H:%M", time.gmtime(mtime))

def truncate_name(name, is_dir=False):
    display_name = name + '/' if is_dir else name
    if len(display_name) > 50:
        return display_name[:47] + '..>'
    return display_name

def build_row(name, mtime, size, is_dir=False):
    display_name = truncate_name(name, is_dir)
    
    link = urllib.parse.quote(name) + ('/' if is_dir else '')
    
    name_pad = 50 - len(display_name)
    if name_pad < 0: 
        name_pad = 0
        
    date_str = format_time(mtime)
    size_str = "-" if is_dir else str(size)
    
    return f'<a href="{link}">{display_name}</a>{" " * name_pad} {date_str} {size_str:>19}'

def generate():
    for dirpath, dirnames, filenames in os.walk(ROOT_DIR):
        dirnames[:] = [d for d in dirnames if not d.startswith('.') and d not in EXCLUDE_DIRS]
        
        files = [f for f in filenames if not f.startswith('.') and f not in EXCLUDE_FILES]
        
        dirnames.sort()
        files.sort()
        
        rel_path = Path(dirpath).relative_to(ROOT_DIR)
        if rel_path == Path('.'):
            display_path = '/'
        else:
            display_path = '/' + str(rel_path).replace('\\', '/') + '/'
            
        html = [
            '<html>',
            f'<head><title>Index of {display_path}</title>',
            '<style>body { background-color: white; color: black; font-family: sans-serif; } pre { font-family: monospace; }</style>',
            '</head>',
            '<body>',
            f'<h1>Index of {display_path}</h1><hr><pre>'
        ]
        
        if display_path != '/':
            html.append('<a href="../">../</a>')
            
        for d in dirnames:
            p = Path(dirpath) / d
            stat = p.stat()
            html.append(build_row(d, stat.st_mtime, 0, is_dir=True))
            
        for f in files:
            p = Path(dirpath) / f
            stat = p.stat()
            html.append(build_row(f, stat.st_mtime, stat.st_size, is_dir=False))
            
        html.append('</pre><hr></body>\n</html>')
        
        index_file = Path(dirpath) / 'index.html'
        with open(index_file, 'w', encoding='utf-8') as out:
            out.write('\n'.join(html))
        

if __name__ == '__main__':
    generate()
