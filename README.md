# OPEN SOURCE : VISEO BOT MAKER

## DESCRIPTION

Ce dashboard consiste à gérer les conversations entre les bots et les utilisateurs grâce à un ou des administrateurs.
Dans le cas où le bot ne répond pas aux attentes de l’utilisateur, le serveur le détecte et l’administrateur pourra ainsi
intervenir et parler au client via le dashboard.
Le projet est toujours en status de développement.


## PRE-REQUIS

1. Installation de Elm : https://guide.elm-lang.org/install.html
2. un IDE, comme Atom par exemple :)
3. Télécharger NodeJS : https://nodejs.org/en/download/


## INSTRUCTIONS POUR DEVELOPPER EN LOCAL

1. Modifier les paramètres de Chrome : faire un nouveau raccourci de Chrome, et modifier ces propriétés :
 Mettre comme cible : "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --disable-web-security --user-data-dir="C:\ChromeDev"
 Ceci permet de désactiver la sécurité pour accéder au serveur

2. Dans un deuxième terminal, se diriger dans le dossier "server"
 Puis taper la commande :
 * créer un nouveau fichier config.json dans le dossier config et y mettre le contenu de config.sample.json
 * npm update
 * npm start

3. Avec un premier terminal, se diriger dans le dossier "dashboard"
Pour lancer le serveur local, taper la commande : elm-app start

4. Aller sur : http://localhost:3000/

TODO Tester
## PACKAGES

L'application comporte de nombreux packages Elm visibles dans le "elm-package.json" du dossier dashboard.


## DESCRIPTION DES BRANCHES GIT

* **Master et Develop** A chaque fois qu'une feature est terminée, on la rajoute sur la branche Develop, et on gère les conflits s'il y en a. Celle-ci doit toujours compiler. Lorsque le code développé est optimisé, nous faisons ensuite une pull request sur le master.

* **Websocket2** Début des encodeurs de conversation et messages dans le fichier Conversation.elm. De plus, des débuts de code à propos de la Date sont présents.

* **feature-handover & feature-handover2** Dans ces deux branches, il y a deux gestions différentes des handlers au niveau serveur. L'un utilise plus les requêtes et l'autre les messages.

*  **feature statistics** Partie serveur sur les stats implémentée mais pour lequel le frontend n'a pas été commencé.

*  **feature-websocket-broadcast**


## RESTE A FAIRE :


1. Encodeur des messages et des conversations (aller sur websocket2) -> envoyer un message lorqu'on clique
sur le logo envoyer.
Un problème persiste au niveau de l'encodeur de la date.

Se référer à ces deux exemples :
* https://ellie-app.com/Y9KSXB9wPba1
* https://ellie-app.com/jYds844LyMa1

Il faut que la date actuelle (lorqu'on clique sur le logo Envoyer) soit transmise dans le JSON "date" et "last_msg_date".
La date atuelle se récupère grâce à Time.now

2. Envoyer un message avec le serveur

3. La partie statistiques

4. Connexion/Déconnexion





## AUTEURS

Aymeric DELOCHE DE NOYELLE
&
Léna SANTAMARIA

avec la direction Technique de Eric BRULATOUT et Jordane GRENAT
dans le cadre d'un projet de Stage
