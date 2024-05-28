#!/bin/bash

# Function to read submodule paths from .gitmodules using awk
get_submodules() {
    awk -F ' = ' '/path = / {print $2}' .gitmodules
}

# Get the list of submodules
submodules=($(get_submodules))

# Demander à l'utilisateur s'il veut utiliser un sous-module spécifique ou le répertoire courant
read -p "Voulez-vous commiter les changements dans un sous-module spécifique ou le répertoire courant? (submodules/current): " choice

if [ "$choice" == "submodules" ]; then
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

if [ -z "$commit_message" ]; then
    if [ "$choice" == "submodules" ]; then
        echo "Message de commit invalide. Veuillez entrer un message de commit."
        exit 1
    else
        commit_message="Update submodules"
    fi
fi
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
