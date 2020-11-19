#!/bin/bash

#Nettoyage de la console
clear

cat /var/log/apache2/access.log |grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" |sort |uniq |sort>/var/log/listelogin2.txt


echo "Adresse IP s'étant connectée à l'Intranet"

cat /var/log/listelogin2.txt
