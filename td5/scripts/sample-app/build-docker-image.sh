#!/usr/bin/env bash
# Arrête le script en cas d'erreur [cite: 183]
set -e

# Récupère le nom et la version du package.json en nettoyant les guillemets 
name=$(npm pkg get name | tr -d '"')
version=$(npm pkg get version | tr -d '"')

# Construit l'image pour plusieurs architectures (AMD64 et ARM64) [cite: 186, 187]
docker buildx build \
  --platform linux/amd64 \
  --load \
  -t "$name:$version" \
  .
