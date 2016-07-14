#!/bin/bash

echo "---- Iniciando instalacao do ambiente de Desenvolvimento PHP [Luiz Lapetina] ---"

echo "--- Atualizando lista de pacotes ---"
sudo apt-get update

echo "--- Definindo Senha padrão para o MySQL e suas ferramentas ---"

DEFAULTPASS="vagrant"
sudo debconf-set-selections <<EOF
mariadb-server	mysql-server/root_password password $DEFAULTPASS
mariadb-server	mysql-server/root_password_again password $DEFAULTPASS
dbconfig-common	dbconfig-common/mysql/app-pass password $DEFAULTPASS
dbconfig-common	dbconfig-common/mysql/admin-pass password $DEFAULTPASS
dbconfig-common	dbconfig-common/password-confirm password $DEFAULTPASS
dbconfig-common	dbconfig-common/app-password-confirm password $DEFAULTPASS
phpmyadmin		phpmyadmin/reconfigure-webserver multiselect apache2
phpmyadmin		phpmyadmin/dbconfig-install boolean true
phpmyadmin      phpmyadmin/app-password-confirm password $DEFAULTPASS 
phpmyadmin      phpmyadmin/mysql/admin-pass     password $DEFAULTPASS
phpmyadmin      phpmyadmin/password-confirm     password $DEFAULTPASS
phpmyadmin      phpmyadmin/setup-password       password $DEFAULTPASS
phpmyadmin      phpmyadmin/mysql/app-pass       password $DEFAULTPASS
EOF

echo "--- Instalando pacotes basicos ---"
sudo apt-get -y install vim curl python-software-properties git-core software-properties-common 

echo "--- Adicionando repositorio do pacote PHP 7.0 e MariaDB ---"
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-key -y adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository -y 'deb [arch=amd64,i386,ppc64el] http://mirror.edatel.net.co/mariadb/repo/10.1/ubuntu trusty main'

echo "--- Atualizando lista de pacotes ---"
sudo apt-get update

echo "--- Instalando MariaDB (Server e Client) e Phpmyadmin ---"
sudo apt-get -y install mariadb-server mariadb-client phpmyadmin

echo "--- Instalando PHP e os módulos necessários, Apache, Redis e XDEBUG ---"
sudo apt-get -y install redis-server  apache2 php7.0 libapache2-mod-php7.0 php7.0-curl php7.0-gd php7.0-mcrypt  php7.0-mysql php7.0-dev php7.0-redis php7.0-xdebug

echo "--- Habilitando mod-rewrite e o PHP 7.0 no Apache ---"
sudo a2enmod rewrite
sudo a2enmod php7.0

echo "--- Reiniciando Apache ---"
sudo service apache2 restart

echo "--- Baixando e Instalando Composer ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer



# Instale apartir daqui o que você desejar 

echo "[OK] --- Ambiente de desenvolvimento concluido ---"
echo "Utilize http://192.168.30.11 para acessar o servidor WEB"
echo "Coloque seus scripts php na pasta ~/[SEU VAGRANT]/www/html"
