#!/usr/bin/env bash
set -e

# Récupération du nom et de la version depuis le package.json
name=$(npm pkg get name | tr -d '"')
version=$(npm pkg get version | tr -d '"')

echo "Lancement du conteneur $name:$version sur le port 8080..."

# docker run : lance le conteneur
# -p 8080:8080 : fait le lien entre ton port local et celui du conteneur [cite: 177, 249]
# --rm : nettoie automatiquement le conteneur à l'arrêt
# --name : donne un nom facile à retrouver au conteneur lancé
docker run -p 8080:8080 --rm --name "$name" "$name:$version"
