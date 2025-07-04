#!/bin/bash
# Terminal greeting with ASCII art, weather, and time for Berkeley, CA

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
ORANGE='\033[38;5;208m'
PINK='\033[38;5;213m'
PURPLE='\033[38;5;141m'
LIME='\033[38;5;154m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ASCII Art - Double gradient color wheel with reverse inner circle
echo -e ""
echo -e "                      ${BOLD}${RED}●●●${ORANGE}●●●${YELLOW}●●●${NC}"
echo -e "                  ${BOLD}${PINK}●●●${NC}             ${BOLD}${LIME}●●●${NC}"
echo -e "               ${BOLD}${MAGENTA}●●●${NC}                   ${BOLD}${GREEN}●●●${NC}"
echo -e "             ${BOLD}${PURPLE}●●●${NC}     ${BOLD}\033[38;5;82m●●●\033[38;5;118m●●●${NC}     ${BOLD}${CYAN}●●●${NC}"
echo -e "           ${BOLD}${BLUE}●●●${NC}    ${BOLD}\033[38;5;46m●●●${NC}     ${BOLD}\033[38;5;154m●●●${NC}    ${BOLD}\033[38;5;51m●●●${NC}"
echo -e "          ${BOLD}\033[38;5;27m●●●${NC}  ${BOLD}\033[38;5;48m●●●${NC}         ${BOLD}\033[38;5;190m●●●${NC}  ${BOLD}\033[38;5;48m●●●${NC}"
echo -e "         ${BOLD}\033[38;5;21m●●●${NC} ${BOLD}\033[38;5;51m●●●${NC}             ${BOLD}\033[38;5;226m●●●${NC} ${BOLD}\033[38;5;46m●●●${NC}"
echo -e "        ${BOLD}\033[38;5;57m●●●${NC} ${BOLD}${CYAN}●●●${NC}               ${BOLD}\033[38;5;220m●●●${NC} ${BOLD}\033[38;5;82m●●●${NC}"
echo -e "        ${BOLD}\033[38;5;93m●●●${NC} ${BOLD}${BLUE}●●●${NC}               ${BOLD}\033[38;5;214m●●●${NC} ${BOLD}\033[38;5;118m●●●${NC}"
echo -e "         ${BOLD}\033[38;5;129m●●●${NC} ${BOLD}\033[38;5;27m●●●${NC}             ${BOLD}\033[38;5;208m●●●${NC} ${BOLD}\033[38;5;154m●●●${NC}"
echo -e "          ${BOLD}\033[38;5;165m●●●${NC}  ${BOLD}\033[38;5;21m●●●${NC}         ${BOLD}\033[38;5;202m●●●${NC}  ${BOLD}\033[38;5;190m●●●${NC}"
echo -e "           ${BOLD}\033[38;5;201m●●●${NC}    ${BOLD}\033[38;5;57m●●●${NC}     ${BOLD}\033[38;5;196m●●●${NC}    ${BOLD}\033[38;5;226m●●●${NC}"
echo -e "             ${BOLD}\033[38;5;198m●●●${NC}     ${BOLD}\033[38;5;93m●●●\033[38;5;129m●●●${NC}     ${BOLD}\033[38;5;220m●●●${NC}"
echo -e "               ${BOLD}\033[38;5;197m●●●${NC}                   ${BOLD}\033[38;5;214m●●●${NC}"
echo -e "                  ${BOLD}\033[38;5;196m●●●${NC}             ${BOLD}\033[38;5;208m●●●${NC}"
echo -e "                      ${BOLD}\033[38;5;196m●●●\033[38;5;202m●●●\033[38;5;208m●●●${NC}"
echo -e ""

# Current time and date
echo -e ""
DATE_TIME=$(date '+%A, %B %d, %Y at %I:%M %p %Z')
echo -e "${YELLOW}📅 Date & Time:${NC} ${ORANGE}$DATE_TIME${NC}"

# Location
echo -e "${CYAN}📍 Location:${NC} ${MAGENTA}Berkeley, California${NC}"

# Weather info
if command -v curl >/dev/null 2>&1; then
    weather=$(curl -s "wttr.in/Berkeley,CA?format=%C+%t+%h+%w" 2>/dev/null | head -1)
    if [ $? -eq 0 ] && [ -n "$weather" ]; then
        echo -e "${BLUE}🌤️  Weather:${NC} ${ORANGE}$weather${NC}"
    else
        echo -e "${BLUE}🌤️  Weather:${NC} ${RED}Weather unavailable${NC}"
    fi
else
    echo -e "${BLUE}🌤️  Weather:${NC} ${RED}Weather unavailable (curl not installed)${NC}"
fi

# System info
SYSTEM_INFO="$(uname -o) $(uname -r)"
echo -e "${MAGENTA}💻 System:${NC} ${ORANGE}$SYSTEM_INFO${NC}"

# User info
USER_INFO="$USER@$(cat /etc/hostname 2>/dev/null || echo 'localhost')"
echo -e "${YELLOW}🏠 User:${NC} ${ORANGE}$USER_INFO${NC}"
echo -e ""

# Fun welcome message
echo ""
echo -e "${BOLD}${CYAN}Welcome back, ${ORANGE}$USER${CYAN}! Ready to build something amazing? 🚀${NC}"
echo ""