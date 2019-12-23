# Créer un vhost automatiquement

Script permettant de mettre en place un vhost automatiquement.  
  
Il est à placer dans le dossier racine www.  
(pour le site monsite.fr se trouvant dans www/monsite.fr, placer le script dans le dossier www. Le dossier monsite.fr sera créé automatiquement).  
    
Le script :
  * créé le dossier du site.
  * créé le fichier .conf dans le répertoire /etc/apache2/sites-available/
  * créé un lien symbolique dans apache.
  * redemarre apache.
  * ajoute le site dans le fichier hosts pour les tests en local.
  
