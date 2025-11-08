#!/bin/bash

set -e

BINGNER_REPO_URL="https://apt.bingner.com/"
BINGNER_REPO_DOMAIN="apt.bingner.com"
BINGNER_REPO_FILE="/etc/apt/sources.list.d/bingner.list"
BINGNER_REPO_ENTRY="deb ${BINGNER_REPO_URL} ./"

AALX_REPO_URL="https://aalx0451.github.io/aalx-repo"
AALX_REPO_DOMAIN="aalx0451.github.io"
AALX_REPO_FILE="/etc/apt/sources.list.d/aalx0451.list"
AALX_REPO_ENTRY="deb ${AALX_REPO_URL}/ ./"
AALX_KEY_URL="https://aalx0451.github.io/aalx-repo/etc/public-key.key"
AALX_KEY_FINGERPRINT="Alexander <aalx2176@gmail.com>"
AALX_PIN_FILE="/etc/apt/preferences.d/aalx0451-pin"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ "$(id -u)" -ne 0 ]; then
  echo "This should be run as root $0" >&2
  exit 1
fi

echo -e "${GREEN}--- Adding AAlx repo ---${NC}"

echo -e "\n${YELLOW}Checking if apt.bingner.com added...${NC}"
if ! grep -qRs --include='*.list' --include='*.sources' "^deb.*${BINGNER_REPO_DOMAIN}" /etc/apt/sources.list /etc/apt/sources.list.d/ ; then
    echo "No, adding..."
    echo "${BINGNER_REPO_ENTRY}" > "${BINGNER_REPO_FILE}"
    echo -e "${GREEN}Added.${NC}"
else
    echo -e "${GREEN}Already added!${NC}"
fi

echo -e "\n${YELLOW}Updating and installing required packages...${NC}"
apt-get update > /dev/null 2> /dev/null
apt-get install -y curl > /dev/null 2> /dev/null
echo -e "${GREEN}Done!${NC}"

echo -e "\n${YELLOW}Checking if aalx-repo added...${NC}"
if ! grep -qRs --include='*.list' --include='*.sources' "^deb.*${AALX_REPO_DOMAIN}" /etc/apt/sources.list /etc/apt/sources.list.d ; then
    echo "No, adding..."
    echo "${AALX_REPO_ENTRY}" > "${AALX_REPO_FILE}"
    echo -e "${GREEN} Success!${NC}"
else
    echo -e "${GREEN}Already added${NC}"
fi

echo -e "\n${YELLOW}Checking if AAlx GPG key installed...${NC}"
if ! apt-key list 2>/dev/null | grep -q "${AALX_KEY_FINGERPRINT}"; then
    echo "No, installing..."
    curl -fsSL "${AALX_KEY_URL}" | apt-key add -
    echo -e "${GREEN}Success!${NC}"
else
    echo -e "${GREEN}Already installed.${NC}"
fi

echo -e "\n${YELLOW}Creating pinning file...${NC}"
echo -e "Package: *\nPin: origin aalx0451.github.io\nPin-Priority: 1002\n" > "${AALX_PIN_FILE}"
echo -e "${GREEN}Creating ${AALX_PIN_FILE} success!${NC}"

echo -e "\n${YELLOW}Updating package lists...${NC}"
apt-get update > /dev/null 2> /dev/null
echo -e "\n${GREEN}--- Done! ---${NC}"
