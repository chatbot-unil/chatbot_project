#!/bin/bash

# Liste des sous-modules
submodules=( "vectordb" "backend" "frontend" )

# Parcourir chaque sous-module
for submodule in "${submodules[@]}"
do
	# test le statut du sous-module (si des changements ont été effectués)
	cd $submodule
	if [ -z "$(git status --porcelain)" ]; then
		echo "No changes in $submodule"
	else
		echo "Committing changes in $submodule"
		git add .
		git commit -m "Automatic commit for $submodule"
		git push origin main
	fi
	cd ..
done

# Mettre à jour la référence des sous-modules dans le dépôt principal
if [ -z "$(git status --porcelain)" ]; then
	echo "No changes in main repository"
else
	echo "Committing changes in main repository"
	git add .
	git commit -m "Automatic commit for main repository"
	git push origin main
fi