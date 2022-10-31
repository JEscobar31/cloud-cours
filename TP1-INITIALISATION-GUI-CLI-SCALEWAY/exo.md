# TP SCALEWAY : 20/10/2022

But du tp : 

Pour chacun des cas, mettre en place l'infrastructure à l’aide de votre
compte et des services Scaleway. Vous effectuerez la mise en place à
l’aide de la console dans un premier temps puis via le CLI Scaleway
dans un second temps


## I) Installation de Scaleway CLI 

### Info  :

> lien utile : https://github.com/scaleway/scaleway-cli

###  Installation & Initialisation :

Version Linux : 

* Dans un premier temps, vérifier la dernière version du CLI sur github 

> https://github.com/scaleway/scaleway-cli/releases/tag/v2.6.1

![](https://i.imgur.com/TRg5TpK.png)


* Maintenant que nous connaissons la dernière version, il suffit d'éxecuter la commande suivante en bien modifiant la version "2.6.1". Cette commande permet d'installer le CLi directement depuis github

> sudo curl -o /usr/local/bin/scw -L "https://github.com/scaleway/scaleway-cli/releases/download/v${VERSION="2.6.1"}/scaleway-cli_${VERSION="2.6.1"}_linux_amd64"

* Ensuite, lorsque l'installation est terminée, nosu allons autoriser l'éxecution du fichier en tant que programme avec la commande suivante :

> sudo chmod +x /usr/local/bin/scw

* L'installation est enfin fini, maintenant nous allons voir l'initialisation du CLI avec l'interface graphique. Pour cela, on va exécuter la commande : 

> scw init 

![](https://i.imgur.com/Sm8FN4g.png)








## II) Exercices 

### Cas n°1 :

1. version graphique 

* création de l'instance :

![](https://i.imgur.com/9wV128i.png)

* création clé ssh conexion instance : 

Il a fallu copier la clé ssh .pub généré via la commande "ssh-keygen" 

![](https://i.imgur.com/PhvPP0p.png)


* test connexion ssh :

![](https://i.imgur.com/IYCIQnz.png)



* Vous installez une base de données à l’aide du service correspondant sur Scaleway.

![](https://i.imgur.com/Q8nNKiP.png)




* A l’aide d’une machine dans le cloud Scaleway (la moins chère possible), vous vous connectez à cette base de données, vous y créez une base avec une table (user: nom,prénom, mail).

![](https://i.imgur.com/mskraoz.png)



* Ajoutez 5 ou 6 user dans la table associée. Faire une sauvegarde de la base de données via Scaleway (dans la console puis via la ligne de commande scw). 

![](https://i.imgur.com/CgBIpgq.png)

![](https://i.imgur.com/0MfuDGP.png)



* Supprimer les utilisateurs. 

![](https://i.imgur.com/urFLQkE.png)


* Restaurer la base de données à l’aide de la sauvegarde faite précédemment (dans la console puis via la ligne de commande scw).



2. Version CLI

* Création instance 

        scw instance server create type=PRO2-XXS zone=fr-par-2 image=ubuntu_jammy root-volume=b:10G additional-volumes.0=b:10G name=scw-instance-group9 ip=new project-id=2ff177fd-3df2-472e-8021-0e3022fb7930

* Création database

        scw rdb instance create project-id=2ff177fd-3df2-472e-8021-0e3022fb7930 name=rdb-groupe9 engine=MySQL-8 user-name=group9 password=Groupe931? node-type=DB-GP-XS disable-backup=false volume-type=bssd volume-size=10G region=fr-par
![](https://i.imgur.com/hYBf8U8.png)


        
    scw rdb database create name=groupe9 region=fr-par instance-id=72028184-c8d1-4117-b6e4-3bd8a2d86404
    
![](https://i.imgur.com/OgqDKfZ.png)

Concernant la réinjection des users c'est la même étape que sur la version graphique.


* Création de la sauvegarde 

        scw rdb backup create database-name=groupe9 instance-id=72028184-c8d1-4117-b6e4-3bd8a2d86404 name=save-after_add_user_cli
        
![](https://i.imgur.com/deZhMU7.png)

* Restauration de la table user 

        scw rdb backup restore e9a52753-6111-4ab1-81f2-35226be3606a database-name=groupe9 instance-id=72028184-c8d1-4117-b6e4-3bd8a2d86404 region=fr-par

![](https://i.imgur.com/e03j96E.png)



### Cas n°2 :

En utilisant la base de données du cas n°1, vous effectuez une requête simple (type
“SELECT * FROM user;”) à l’aide du service Serverless de Scaleway. Vous créez la fonction
Serverless à l’aide du CLI Scaleway.

![](https://i.imgur.com/HiXmnCE.png)


+ Mise en place de l'espace de travail :

> installer npm 

> Exécuter : npm i serverless

> Exécuter la commande : serverless create --template-url https://github.com/scaleway/serverless-scaleway-functions/tree/master/examples/python3 --path SelectSql

> Rentrer dans le dossier SelectSql

> Installer le package "mysql connector python" : pip install mysql-connector-python --target ./package

> Modifier le fichier serverless et modifier la première ligne en y renseignant le nom du namespace "tpcloud"


Serverless.py
```
service: tp1-v2
configValidationMode: off
provider:
  name: scaleway
  runtime: python310 # Available python runtimes are listed in documentation
  # Global Environment variables - used in every functions
  env:
    test: test

plugins:
  - serverless-scaleway-functions

package:
  patterns:
    - '!node_modules/**'
    - '!.gitignore'
    - '!.git/**'

functions:
  first:
    handler: handler.handle
    # description: ""
    # Local environment variables - used only in given function
    env:
      local: local
```


>Editer le fichier handler.py et y ajouter le code suivant :

Handler.py
```
import mysql.connector

def handle(event, context):
    mydb = mysql.connector.connect(
     host="51.158.59.143",
     user="test",
     password="Teste99?",
     database="users",
     port="51835"
    )

    mycursor=mydb.cursor()

    mycursor.execute("SELECT * FROM user")

    myresult = mycursor.fetchall()

    print(myresult)

    return {
    "body": {
      "message": myresult,
    },
    "statusCode": 200,
  }

```

> Sortir du dossier et zip le dossier SelectSql : zip -r SelectSql.zip SelectSql


+ EN CLI


* Création namespace: 

>  scw function namespace create name=test2 region=fr-par  project-id=2ff177fd-3df2-472e-8021-0e3022fb7930

![](https://i.imgur.com/mv1DzEN.png)


* Création de la fonction

> scw function function create runtime=python310 handler=SelectSql/handler.handle region=fr-par -c /SelectSql


+ En version web

> Créer une fonction et choisir les infos suivantes :
>- type de code d'entrée : télécharger un zip
![](https://i.imgur.com/imHVj7O.png)

>- runtime : python 3.10
>- gestionnaire : SelectSql/handler.handle 
>- déposer le zip
>- nom de fonction SelectSql
>- Cliquer sur le bouton "crée la fonction"

> Une fois la fonction créé, attendre le déploiement et copier le lien HTTP pour visualiser le résultat de la requête.

![](https://i.imgur.com/TruFKgM.png)


### Cas n°3 :

- Création des 2 instances : 

> scw instance server create type=PLAY2-PICO zone=fr-par-1 image=ubuntu_jammy root-volume=b:10G additional-volumes.0=b:10G name=scw-nginx1 ip=new project-id=2ff177fd-3df2-472e-8021-0e3022fb7930


> scw instance server create type=PLAY2-PICO zone=fr-par-1 image=ubuntu_jammy root-volume=b:10G additional-volumes.0=b:10G name=scw-nginx2 ip=new project-id=2ff177fd-3df2-472e-8021-0e3022fb7930



- Mise en place du serveur web avec NGINX (pour chaque instances)

Instalation de NGINX :
> sudo apt install nginx

Vérification service en marche :
> systemctl status nginx


- Modification du fichier index

Sur chaque instance, la page web qui affichera l'id de l'instance se trouve à cet emplacement :
>/var/www/tpcloud/html/index.html

Sur chaque instance, nous avons modifier le titre h1 en y ajoutant instance id (exempel ci-dessous)

![](https://i.imgur.com/vrQNu2S.png)

![](https://i.imgur.com/5KXxEIl.png)


- Création du Load Balancer en version graphique

![](https://i.imgur.com/FPZKyu6.png)

![](https://i.imgur.com/7v9Sixv.png)

![](https://i.imgur.com/Vk0n6f9.png)


- Résultat

Pour tester que cela fonctionne, lorsqu'on va sur l'ip sur LB et que l'on raffraichit la page, le titre h1 switch entre le serveur nginx1 et nginx2




*  Création du LoadBalancer en CLI

Commande CLI qui permet de créer le load balancer avec les arguments suivants :
> swc lb lb create project-id=2ff177fd-3df2-472e-8021-0e3022fb7930 zone=fr-par-1 type=LB-S ssl-compatibility-level=ssl_compatibility_level_intermediate







