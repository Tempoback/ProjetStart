#!/bin/bash

#On vide la console
clear

#Déclaration de variable
dateJ=$(date +%F)

saveFile=/var/Sauvegarde/$dateJ


if [ ! -d $savefile ]
then
	mkdir $saveFile
	echo "Création du fichier de sauvegarde journalier"
else
	echo "Le fichier de sauvegarde journalier existe déjà, passage à la synchronisation"
fi
#Synchronisation
rsync -rltgoD --ignore-errors --force /home $saveFile

echo "Synchronisation terminée !"
