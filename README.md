# OPEN SOURCE : VISEO BOT MAKER


## DESCRIPTION


Ce dashboard consiste à gérer les conversations entre les bots et les utilisateurs grâce à un ou des administrateurs.
Dans le cas où le bot ne répond pas aux attentes de l’utilisateur, le serveur le détecte et l’administrateur pourra ainsi
intervenir et parler au client via le dashboard.

### User Stories

* US1 : En tant qu'agent, je peux me connecter à l'interface dashboard et aussi me déconnecter
* US2 : Je peux voir la liste des conversations en cours. Je peux voir sur chaque conversation leur statut. Je peux voir qui discute (l’agent ou le bot).
* US3 : Je peux filtrer la liste avec les statuts suivant :
     - Tout
     - Sans alerte
     - Avec alerte
     - Suspendu (c’est-à-dire qu’un agent a pris la main)
La liste des conversations se met à jour en temps réel

* US4 : Je peux voir le contenu d’une conversation. Je peux cliquer sur une conversation et voir son contenu. La conversation se met à jour en temps réel et je peux la fermer.
* US5 : Je peux prendre la main sur une conversation c’est à dire désactiver le bot. Je peux alors répondre au client et converser.
* US6 : Je peux rendre la main sur une conversation c’est à dire réactiver le bot.
* US7 : Je peux voir les statistiques comme le nombre de conversations en cours, le nombre d’utilisateurs cette semaine, le temps moyen par conversation ou le nombre moyen de messages par conversation
* US8 : Pour chaque statistique, je peux voir une courbe en cliquant dessus
  - Nombre de conversations par jour (sur 7 jours/ 30 jours)
  - Nombre d’utilisateurs différents par jour (sur 7 jours/30 jours)
  - % conversations en alertes contre les conversations totales par jour (sur 7 jours/30 jours)
  - Temps moyen de conversations par jour ( sur 7 jours / 30 jours)


## PRE REQUIS

Connaisances en Elm, un langage fonctionnel


## INSTALLATION

1. Installation de Elm : https://guide.elm-lang.org/install.html
2. un IDE, Atom c'est cool
3. Télécharger NodeJS : https://nodejs.org/en/download/



## INSTRUCTIONS

1. Modifier les paramètres de Chrome : faire un nouveau raccourci de Vhrome, et modifier ces propriétés :
 Mettre comme cible : "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --disable-web-security --user-data-dir="C:\ChromeDev"
 Ceci permet de désactiver la sécurité pour accéder au serveur


2. Avec un premier terminal, se diriger dans le dossier "dashboard"
Pour lancer le serveur local, taper la commande : elm-app start

3. Dans un deuxième terminal, se diriger dans le dossier "server"
Puis taper la commande :
* npm update
* npm start

4. Aller sur Chrome et taper : http://localhost:3000/



## PACKAGES

L'application comporte beaucoup de packages Elm visibe dans le "elm-package.json" du dossier dashboard.

Exemple pour intaller un package :
elm-package install elm-community/string-extra



## DESCRIPTION DES BRANCHES GIT

* Master et Develop

  Version la plus avancée du projet sans bugs

* Websocket2

  Début des encodeurs de conversation et messages dans le fichier Cinversation.elm

* feature-handover

* feature-handover2

*  feature statistics

  Partie serveur sur les stats implémentée mais frontend pas commencé.

*  feature-websocket-broadcast






## RESTE A FAIRE :


1. Encodeur des messages et des conversations (aller sur websocket2) -> envoyer un message lorqu'on clique
sur le logo envoyer.
Problème avec l'encodeur de la date

Se référer à ces deux exemples :
* https://ellie-app.com/Y9KSXB9wPba1
* https://ellie-app.com/jYds844LyMa1

Il faut que la date actuelle (lorqu'on clique sur l'image envoyer) soit transmise dans le JSON "date" et "last_msg_date".
La date atuelle se récupère grâce à Time.now

2. Envoyer un message avec le serveur

3. La partie statistiques

4. Connexion/Déconnexion





## AUTEURS

Eric BRULATOUT
&
Aymeric DELOCHE DE NOYELLE
&
Léna SANTAMARIA
