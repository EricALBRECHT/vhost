#!/bin/bash

####################################################################################
# EasyVhost
# Utilité: Configurer un vhost automatiquement sur un serveur LAMP
# Usage: ./easyVhost.sh , le rendre executable si besoin chmod +x ./easyVhost.sh
# Auteur: Eric ALBRECHT <e.albrecht@outlook.fr>
# Mise à jour le: 23/12/2019
####################################################################################

#fonction vhostCreat , creation su fichier vhost.conf
vhostCreate()
{
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
	if [ -f "/etc/apache2/sites-available/$nomProjet.conf" ];then
		sudo rm "/etc/apache2/sites-available/$nomProjet.conf"
		echo -e "Ancien fichier $nomProjet.conf supprimé.\n"
	fi
		sudo mv "$nomProjet".conf /etc/apache2/sites-available/"$nomProjet".conf
		echo -e "Fichier $nomProjet.conf créé.\n"
}

#recupération du nom de l'utilisateur et du chemin d'execution.
utilisateur=$USER
path=$PWD
 
clear

if [ $utilisateur == 'root' ]; then
	echo "Ne PAS utiliser la commande 'sudo' pour executer ce script"
	exit 0
else

	echo "!!! Attention ce script doit etre placé et executé depuis votre dossier www !!!"
	  
	read -p  "Appuyer sur une touche pour continuer ou CTRL-C pour stopper" 
	echo -e "\n"
	read -p 'Saisir le nom du projet: ' nomProjet
#si pas de nom de projet valide, on arrete le script
	if [ -z $nomProjet ]; then
  		echo "Merci de saisir un nom de projet valide !"
		echo "arret du script."
		exit 0
	fi

#Création du repertoire du site
	if [ -d "$path/$nomProjet" ];then
		echo -e "Le dossier $nomProjet existe ! Il n'a pas été modifié.\n";
	else
		mkdir "$path/$nomProjet"
		if [ -d "$path/$nomProjet" ];then
			echo -e "Creation du repertoire projet nomProjet dans $path/ ...Fait !\n"	
		else
			echo -e "Creation du repertoire projet nomProjet dans $path/ ...Echec!\n"
		fi
	fi


#Création du fichier .conf
	if [ -f "/etc/apache2/sites-available/$nomProjet.conf" ];then
		echo -e "Le fichier $nomProjet.conf existe déja !\n";
		 
		while true; do
	    read -p "Voulez vous le remplacer ? [y/n]" yn
	    case $yn in
		[Yy]* ) vhostCreate; break;;
		[Nn]* ) echo "Arret du script."; exit;;
		* ) ;;
	    esac
	done
	else
		
		vhostCreate
	fi

#ajout d'un lien symbolique dans apache
	echo -e "\nCréation du lien symbolique dans Apache."
	read -p 'Patientez un instant...' -t 5 -s temp 
	echo -e "\n"
	sudo a2ensite "$nomProjet".conf
	echo -e "redemarrage du serveur Apache...\n"
	sudo service apache2 reload
	echo -e "Ajout du site au fichier Hosts...\n"
	cd /etc
#ajout du nom du site dans le fichier hosts
	sudo sed -i "2i127.0.0.1       $nomProjet" hosts

	echo -e 'Script terminé\n'
	echo -e "A partir de là vous pouvez afficher la page dans le navigateur avec l'adresse :\n"
	echo -e "http://$nomProjet\n"
	exit 0
fi

