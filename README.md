## arm-apple-darwin repo

Hello, world!

Soon I'll add package list. 

All packages are arm-apple-darwin. Compiled on iPad 2, iOS 6 (on-device)

PLANNED: gcc 14; Clang/LLVM; http site (Jekyll)

PLANNED(UPD): gcc is unreal to compile due to arch issues.

UPD(2): I COMPILED LLVM/GCC 2.5. YEEEEEEE. UPD: clearly unstable. dont use it pls

UPD(3): I successfully compiled Clang 3.3. anyway, there's much work – first of all I'm going to compile Clang 4.0.1 and release it. Stay noticed 

Anyway, if you want to help me and/or you don't have time to wait me to compile it, I released CMake+Ninja. you can use Cydia's GCC to compile LLVM/Clang 3.3 

UPD(4): Clang 3.9.1 released. LLVM checks passed, but can't guarantee stability rn. 

## REPO IS AT MILESTONE 2 NOW

What do I mean? 

Now all packages are armv7 (armv6 or even armv4t previously, right). So I'll maybe release some libraries. 

What's planned NOW? I'm going to compile 4.0.1 with this things

* X86;AArch64 target support
* Compiler-RT library
* I'll bootstrap it (first build with -O0 :D)

### Hello again, people!

Yes, no activity for a week. 

I'm busy. I built ~10 packages, but won't release until I'll build LLVM/Clang+LibC++ (and maybe Flang/Classic Flang and compiler-rt). I've reached C++17 support (LLVM 5.0.1)

LLD 9.0 is unstable btw (at least for LibC++), but I built it static. Of course, no release soon. I build all the compilers with -O1 now. Hope 5.0.1 works. 

Probably LLVM 10+ ARM optimizer is stable. Or not!

### Well...

Clang 6.0 released. 100% stable. Can compile itself. 

Maybe 7.0 soon. But no more Clang, sorry. I'm tired. Anyway, better than 3.7 from Cydia.