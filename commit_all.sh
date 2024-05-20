#!/bin/bash

# Liste des sous-modules
submodules=( "vectordb" "backend" "frontend" )

# Parcourir chaque sous-module
for submodule in "${submodules[@]}"
do
  echo "Committing changes in $submodule"
  cd $submodule
  git add .
  git commit -m "Automatic commit for $submodule"
  git push origin main
  cd ..
done

# Mettre à jour la référence des sous-modules dans le dépôt principal
git add .
git commit -m "Mise à jour des sous-modules"
git push origin main
