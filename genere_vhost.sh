#!/bin/bash
clear
echo "!!! Attention ce script doit etre placé et executé depuis votre dossier www !!!" 
read -p  "Appuyer sur une touche pour continuer ou CTRL-C pour stopper" -s var
echo -e "\n"
read -p 'Saisir le nom du projet: ' nomProjet

utilisateur=$USER
path=$PWD

echo -e "Creation du repertoire projet...\n"

echo "$path"

mkdir "$path/$nomProjet"

touch "$nomProjet".conf
echo  "<VirtualHost *:80>">>"$nomProjet".conf
echo  "    ServerAdmin webmaster@$nomProjet">>"$nomProjet".conf
echo  "    ServerName www.$nomProjet">>"$nomProjet".conf
echo  "    ServerAlias $nomProjet">>"$nomProjet".conf
echo  "    DocumentRoot $path/$nomProjet">>"$nomProjet".conf
echo  "    <Directory $path/$nomProjet/>">>"$nomProjet".conf
echo  "    AllowOverride All">>"$nomProjet".conf
echo  "    Require all granted">>"$nomProjet".conf
echo  "    </Directory>">>"$nomProjet".conf
echo  "    ErrorLog /var/log/apache2/${nomProjet}-error.log">>"$nomProjet".conf
echo  "    LogLevel warn">>"$nomProjet".conf
echo  "    CustomLog  /var/log/apache2/${nomProjet}-access.log combined">>"$nomProjet".conf
echo  "    ServerSignature Off">>"$nomProjet".conf
echo  "</VirtualHost>">>"$nomProjet".conf

sudo mv "$nomProjet".conf /etc/apache2/sites-available/"$nomProjet".conf

read -p 'Patientez un instant...' -t 5 -s temp 
echo -e "\nCréation du lien symbolique dans apache...\n"
sudo a2ensite "$nomProjet".conf
echo -e "redemarrage du serveur Apache...\n"
sudo service apache2 reload
echo -e "Ajout du site au fichier Hosts...\n"
cd /etc

sudo sed -i "2i127.0.0.1       $nomProjet" hosts

echo -e 'Script terminé\n'
echo 'Merci Eric ;-)'
exit 0



