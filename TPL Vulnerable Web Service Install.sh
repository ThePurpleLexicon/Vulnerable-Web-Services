#!/bin/bash
#
NC='\033[0m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
echo -e "\n${GREEN}THE ${PURPLE}PURPLE ${GREEN}LEXICON'S WEB APP ASSESSMENT TRAINER INSTALLATION${NC}"
echo -e "\nThis script will install DigiNinja's DVWA and OWASP's Juice Shop web services. These web servers are intentionally ${YELLOW}vulnerable ${NC}for the purposes of penetration testing. For more information, please visit:\n\nDigiNinja's DVWA GitHub repo: https://github.com/digininja/DVWA\nOWASP's Juice Shop page: https://owasp.org/www-project-juice-shop/\n\nAll credit and rights belong to DigiNinja for DVWA and OWASP for Juice Shop.\n"
sleep 7
echo -e "\n${YELLOW}Installing DVWA now...${NC}"
cd /var/www/html
sudo apt update && sudo apt install -y apache2 mariadb-server mariadb-client php php-mysqli php-gd libapache2-mod-php nodejs npm
sudo updatedb
sudo git clone https://github.com/digininja/DVWA.git
sudo service apache2 start
sudo systemctl enable apache2
cd DVWA
sudo cp config/config.inc.php.dist config/config.inc.php
sudo service mariadb start
sudo systemctl enable mariadb
sudo mysql -Bse "create database dvwa;create user dvwa@localhost identified by 'p@ssw0rd';grant all on dvwa.* to dvwa@localhost;flush privileges;"
phpfile=$(locate /apache2/php.ini)
sudo sed -i 's/"allow_url_include = Off"/"allow_url_include = On"/g' $phpfile
sudo chown www-data "/var/www/html/DVWA/hackable/uploads/"
sudo chown www-data "/var/www/html/DVWA/config"
echo -e "\n${GREEN}DVWA is installed.\n" && sleep 5 && echo -e "${YELLOW}Installing OWASP's Juice Shop...\n${NC}"
cd /var/www/html/
sudo git clone https://github.com/juice-shop/juice-shop.git --depth 1
cd juice-shop
sudo npm install
echo -e "\n${GREEN}OWASP's Juice Shop is installed!${NC}"
echo -e '\nFurther start-up and configuration instructions found in:'
locate "Vulnerable Web Services Instructions.txt"
echo -e "\n\n"


