#!/bin/bash

# ------------ CONFIGS -----------
REPO_URL_GUACAMOLE_CLIENT="https://github.com/FID-PAM/fidranet.git"
WAR_NAME="fidranet.war"
WEBAPPS_DIR="/opt/tomcat/webapps"

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "\n${CYAN}----------------------------------------------${RESET}"
echo -e "${CYAN}      Fidranet WAR Update Automation          ${RESET}"
echo -e "${CYAN}----------------------------------------------${RESET}\n"

# Clean up previous extracted folder if exists
if [ -d "fidranet" ]; then
    echo -e "${YELLOW}[Info] Previous fidranet directory found. Removing...${RESET}"
    rm -rf fidranet
fi

echo -e "${YELLOW}[Step 1] Cloning Fidranet repository...${RESET}"
git clone "$REPO_URL_GUACAMOLE_CLIENT"
if [ $? -ne 0 ]; then
    echo -e "${RED}[Error] Failed to clone repository: $REPO_URL_GUACAMOLE_CLIENT${RESET}"
    exit 10
fi
echo -e "${GREEN}[Success] Repository cloned successfully.${RESET}\n"

cd fidranet || { echo -e "${RED}[Error] Cannot change to fidranet directory!${RESET}"; exit 11; }

if [ ! -f "$WAR_NAME" ]; then
    echo -e "${RED}[Error] WAR file ($WAR_NAME) not found in the repository folder!${RESET}"
    cd ..
    rm -rf fidranet
    exit 12
fi

echo -e "${YELLOW}[Step 2] Removing old WAR file from Tomcat webapps...${RESET}"
if [ -f "$WEBAPPS_DIR/$WAR_NAME" ]; then
    sudo rm -f "$WEBAPPS_DIR/$WAR_NAME"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[Success] Old WAR file removed successfully.${RESET}"
    else
        echo -e "${RED}[Error] Failed to remove old WAR file. Check permissions.${RESET}"
        cd ..
        rm -rf fidranet
        exit 13
    fi
else
    echo -e "${YELLOW}[Warn] No old WAR file existed in $WEBAPPS_DIR.${RESET}"
fi

echo -e "${YELLOW}[Step 3] Copying new WAR file to Tomcat webapps...${RESET}"
sudo cp "$WAR_NAME" "$WEBAPPS_DIR/"
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[Success] New WAR file copied to $WEBAPPS_DIR.${RESET}"
else
    echo -e "${RED}[Error] Failed to copy new WAR file!${RESET}"
    cd ..
    rm -rf fidranet
    exit 14
fi

cd ..
rm -rf fidranet

# Move & cleanup WAR file and directory
if [ -f /opt/tomcat/webapps/fidranet.war ]; then
    sudo mv /opt/tomcat/webapps/fidranet.war /opt/tomcat/webapps/guacamole.war
    echo -e "${GREEN}[Success] fidranet.war replaced as guacamole.war.${RESET}"
else
    echo -e "${RED}[Error] fidranet.war not found in webapps!${RESET}"
    exit 15
fi

if [ -d /opt/tomcat/webapps/fidranet ]; then
    sudo rm -rf /opt/tomcat/webapps/fidranet/
    echo -e "${GREEN}[Success] Old fidranet exploded directory removed.${RESET}"
else
    echo -e "${YELLOW}[Warn] No fidranet exploded directory found. Skipping removal.${RESET}"
fi

echo -e "${CYAN}----------------------------------------------${RESET}"
echo -e "${CYAN}      Fidranet WAR update COMPLETED!          ${RESET}"
echo -e "${CYAN}----------------------------------------------${RESET}\n"
