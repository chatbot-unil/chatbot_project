#!/bin/bash

# Liste des sous-modules
submodules=( "vectordb" "backend" "frontend" )

# Demander à l'utilisateur d'entrer un message de commit
read -p "Enter your commit message: " commit_message

# Vérifier si un sous-module a été passé en argument
if [ $# -eq 1 ]; then
    specific_submodule=$1
    if [[ " ${submodules[@]} " =~ " ${specific_submodule} " ]]; then
        submodules=("$specific_submodule")
    else
        echo "Error: Submodule '$specific_submodule' not found in the list."
        exit 1
    fi
fi

# Parcourir chaque sous-module
for submodule in "${submodules[@]}"
do
    # Aller dans le répertoire du sous-module
    cd $submodule
    
    # Vérifier les changements dans le sous-module
    if [ -z "$(git status --porcelain)" ]; then
        echo "No changes in $submodule"
    else
        echo "Committing changes in $submodule"
        git add .
        git commit -m "$commit_message"
        
        # Pousser les changements vers la branche courante
        current_branch=$(git rev-parse --abbrev-ref HEAD)
        git push origin $current_branch
    fi
    
    # Retourner au répertoire principal
    cd ..
done

# Mettre à jour la référence des sous-modules dans le dépôt principal
if [ -z "$(git status --porcelain)" ]; then
    echo "No changes in main repository"
else
    echo "Committing changes in main repository"
    git add .
    git commit -m "$commit_message"
    
    # Pousser les changements vers la branche courante
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push origin $current_branch
fi
