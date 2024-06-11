# Git global du projet chatbot

## Introduction

Ce git contient le code du projet chatbot. Il fait partie de mon projet de bachelor. Le but de ce projet est de créer un chatbot qui permet de répondre à des questions sur des données statistiques. Le chatbot sera capable de répondre à des questions sur des données statistiques provenant de l'annuaire statistique de l'Université de Lausanne ainsi que de faire des graphiques.

## Technologies utilisées

Le projet est composé de trois parties : le frontend, le backend et la base de données vectorisée. Le frontend est écrit en JavaScript et utilise le framework React. Le projet utilise également la librairie Material-UI pour les composants graphiques. Les interactions avec le backend pour la partie chat en temps réel sont gérées par la librairie Socket.io. Tandis que les interactions avec le backend pour autre chose que le chat se fera via des requêtes HTTP. Pour la gestion des routes, le projet utilise React Router. De plus, le projet utilise TypeScript pour le typage. La base de données vectorisée sera contenue dans un conteneur Docker. La base de données vectorisée sera chromadb. Chromadb est une base de données vectorisée open-source qui permet de stocker des vecteurs. Elle sera utilisée pour stocker les vecteurs des données statistiques de l'annuaire statistique de l'Université de Lausanne. Et accessible via le backend du projet chatbot. Le backend est écrit en Python et utilise le framework FastAPI. FastAPI est un framework web moderne pour construire des APIs avec Python 3.6+ basé sur des annotations de type. Il est très rapide (hautes performances) et facile à apprendre. Concernant l'interaction avec les LLM (Large Language Models), j'utilise la librairie langchain qui permet de faire des requêtes à des modèles de langage ainsi que de faire des requêtes à une base de données vectorisée.

## Installation

Le projet est composé de trois parties : le frontend, le backend et la base de données vectorisée. Pour installer le projet, il suffit de suivre les instructions de chaque partie.

Pour récupérer tous les sous-modules, il suffit de faire :

```bash
git submodule update --init --recursive
```

## Utilisation

Le projet est composé de trois parties : le frontend, le backend et la base de données vectorisée. Pour tout lancer il suffit de faire : 

```bash
docker-compose up --build
```
