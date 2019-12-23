# Créer un vhost automatiquement

Script permettant de mettre en place un vhost automatiquement sur sa propre machine.  
  
Il est à placer dans le dossier racine www et à executer depuis le Terminal.  
(pour le site monsite.fr se trouvant dans www/monsite.fr, placer le script dans le dossier www. Le dossier monsite.fr sera créé automatiquement).  
    
Le script :
  * créé le dossier du site.
  * créé le fichier .conf dans le répertoire /etc/apache2/sites-available/
  * créé un lien symbolique dans apache.
  * redlance la configuration d'Apache.
  * ajoute le site dans le fichier hosts pour les tests en local.  

Cette configuration est minimal. Elle n'est pas à reproduire en production.  

