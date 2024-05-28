#!/bin/bash

# Liste des sous-modules
submodules=( "vectordb" "backend" "frontend" )

# Demander à l'utilisateur s'il veut utiliser un sous-module spécifique ou le répertoire courant
read -p "Voulez-vous commiter les changements dans un sous-module spécifique ou le répertoire courant? (submodule/current): " choice

if [ "$choice" == "submodule" ]; then
    read -p "Entrez le nom du sous-module: " specific_submodule
    if [[ " ${submodules[@]} " =~ " ${specific_submodule} " ]]; then
        submodules=("$specific_submodule")
    else
        echo "Nom de sous-module invalide. Les sous-modules valides sont: ${submodules[@]}"
        exit 1
    fi
elif [ "$choice" == "current" ]; then
    submodules=(".")
else
    echo "Choix invalide. Les choix valides sont: submodule/current"
    exit 1
fi

# Demander à l'utilisateur d'entrer un message de commit
read -p "Entrez un message de commit: " commit_message

# Parcourir chaque sous-module
for submodule in "${submodules[@]}"
do
    # Aller dans le répertoire du sous-module ou rester dans le répertoire courant
    if [ "$submodule" != "." ]; then
        cd $submodule
    fi
    
    # Vérifier les changements dans le sous-module ou répertoire courant
    if [ -z "$(git status --porcelain)" ]; then
        echo "Pas de changements dans $submodule"
    else
        echo "Commit des changements dans $submodule"
        git add .
        git commit -m "$commit_message"
        
        # Pousser les changements vers la branche courante
        current_branch=$(git rev-parse --abbrev-ref HEAD)
        git push origin $current_branch
    fi
    
    # Retourner au répertoire principal si on est dans un sous-module
    if [ "$submodule" != "." ]; then
        cd ..
    fi
done

# Mettre à jour la référence des sous-modules dans le dépôt principal (uniquement si on a traité des sous-modules)
if [ "$choice" == "submodule" ]; then
    if [ -z "$(git status --porcelain)" ]; then
        echo "Pas de changements dans le dépôt principal"
    else
        echo "Commit des changements dans le dépôt principal"
        git add .
        git commit -m "$commit_message"
        
        # Pousser les changements vers la branche courante
        current_branch=$(git rev-parse --abbrev-ref HEAD)
        git push origin $current_branch
    fi
fi
