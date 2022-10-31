# Infrastructure 1:


### AWS :

::: info
Pour cette première simulation, j'ai selectionné le service EC2 et j'ai appliqué 
les paramètres suivants : 
+ 16 Go de RAM minimum
+ 4 vCPU
+ 100 Go de stockage disque
:::

+ SE + RAM + vCPU : 

![](https://i.imgur.com/6zOCErH.png)

+ Plan tarification : ATTENTION BIEN CHOISIR AUCUN PLAN

![](https://i.imgur.com/ekKvtMx.png)


+ Espace de stockage

![](https://i.imgur.com/MOVGMid.png)
Calcul : 
100 Go x 0,116 USD x 1 instances = 11,60 USD (coût de stockage EBS)
Coût de stockage EBS: 11,60 USD
Tarification Amazon Elastic Block Storage (EBS) (mensuellement): 11.60 USD

+ Résultat mensuel & annuel en USD:

![](https://i.imgur.com/E7N2V4T.png)






### AZURE:

::: info
Pour cette deuxième simulation sur Azure, j'ai selectionné le service "ORDINATEUR VIRTUEL" et j'ai appliqué 
les paramètres suivants : 
+ 16 Go de RAM minimum
+ 4 vCPU
+ 128 Go de stockage SSD
:::

+ SE + RAM + CPU

![](https://i.imgur.com/JdQ3fLZ.png)

+ Espace de stockage

![](https://i.imgur.com/fcLlEk7.png)

+ Résultat mensuel & annuel :

![](https://i.imgur.com/haEjx4G.png)


### Scaleway :

::: info
Pour cette deuxième simulation sur Azure, j'ai selectionné le service "ORDINATEUR VIRTUEL" et j'ai appliqué 
les paramètres suivants : 
+ 16 Go de RAM 
+ 4 vCPU
+ 128 Go de stockage SSD
:::


![](https://i.imgur.com/pDyQerB.png)


### GCP :

::: info
Pour cette deuxième simulation sur Azure, j'ai selectionné le service "ORDINATEUR VIRTUEL" et j'ai appliqué 
les paramètres suivants : 
+ 16 Go de RAM 
+ 4 vCPU
+ 100 Go de stockage HDD
:::

![](https://i.imgur.com/SkIUR5O.png)



# Infrastructure 2:

::: info
Le but pour cette infrastructure 2 est de calculer le prix entre chacun des provider en fonction des caractéristiques suivants : 
+ 16 Go de RAM minimum 
+ 3 vCPU
+ 20 Go de stockage disque par serveur 

Attention : Particularité : 3 serveurs sont éteints la nuit de 22h à 6h du matin

:::

### AWS :

:::info
Pour cette première simulation, il a fallu le faire en 2 fois. La première avec 3 machines sans contraintes d'heure et la deuxième avec les 3 machines éteintes de 22h à 6h.

:::

#### Tarif 3 machines sans contraintes d'heure :

+ vCpu + RAM

![](https://i.imgur.com/9iDtHeS.png)

+ Plan tarification : ATTENTION BIEN CHOISIR AUCUN PLAN

![](https://i.imgur.com/ekKvtMx.png)

+ Stockage

![](https://i.imgur.com/BrGQmx7.png)

Calcul :

20 Go x 0,116 USD x 3 instances = 6,96 USD (coût de stockage EBS)
Coût de stockage EBS: 6,96 USD
Tarification Amazon Elastic Block Storage (EBS) (mensuellement): 6.96 USD


#### Tarif 3 machines avec contraintes d'heure :

+ vCPU + RAM :

![](https://i.imgur.com/Nkb4DxP.png)


+ Stockage disque :

![](https://i.imgur.com/0bBdOqa.png)

Calcul :

20 Go x 0,116 USD x 3 instances = 6,96 USD (coût de stockage EBS)
Coût de stockage EBS: 6,96 USD
Tarification Amazon Elastic Block Storage (EBS) (mensuellement): 6.96 USD

+ Contraintes d'heure (fonctionnement sur 16h/jour):

![](https://i.imgur.com/AJXrsVn.png)

+ Résultats global par mois :

![](https://i.imgur.com/R8LIx9I.png)





### AZURE

:::info
Pour cette deuxième simulation, il a fallu le faire en 2 fois. La première avec 3 machines éteintes de 22h à 6h et la deuxième avec les 3 machines sans contraintes d'heure.
:::

Pour cette infrastructure nous allons utiliser les services:
+ 6 Ordinateur Virtuel qui ont 4 Coeur et 8Go de RAM sans stockage temporaire avec un disque de 32Go.


Comme vous pouvez voir ci-dessous les ordinateur vont fonctionner 480h/mois car il sont allumer 16h/jours pendant 30 jours et 16x30 = 480

##### les ordinateurs avec contrainte d'heure


![](https://i.imgur.com/qiOLP5O.png)
![](https://i.imgur.com/eTndRwF.png)
![](https://i.imgur.com/YOPME4a.png)


##### les ordinateurs sans contrainte d'heure

![](https://i.imgur.com/eRGUuHK.png)
![](https://i.imgur.com/hC0DlQk.png)
![](https://i.imgur.com/LVMYvZR.png)

##### Calcul mensuel

Le coup mensuel de cette infrastructure via Azure couterais 822.10$
(327,80 + 494,30 = 822,10)



### GCP :



![](https://i.imgur.com/txDFqy0.png)

Soit 709,45 $


### Scaleway :
Pour cette infrastructure nous allons utiliser les services:
+ 6 instance qui ont 4 Coeur et 8Go de RAM avec un block storage de 20Go


![](https://i.imgur.com/TuAgZTn.png)

Il faut multiplé par 3 le prix ci-dessus car il y as 3 instances.
42.44x3 = 127.32 en Euros ce qui fait 125.38$



![](https://i.imgur.com/Q0A7F9V.png)

Comme vous pouvez voir ci-dessus les ordinateur vont fonctionner 480h/mois car il sont allumer 16h/jours pendant 30 jours et 16x30 = 480
Il faut multiplé par 3 le prix ci-dessus car il y as 3 instances.
27.90x3 = 83.72 en Euros ce qui fait 82.44$


Le coup total de l'infrastructure sur Scalway est de 207.82$


## INFRASTRUCTURE 3


### Azure

Pour cette infrastructure nous allons utiliser les services:
+ 3 Ordinateur Virtuel (2 Coeur, 4 Go de RAM et 20 Go de stockage Temporaire et un disque de 64Go)
+ Un Load Balancer
+ Azure SQL Managed Instance (4 Coeur et 1 disque de 32 Go)


LES 3 VMS

![](https://i.imgur.com/lD4CmNj.png)
![](https://i.imgur.com/tlTImkm.png)
![](https://i.imgur.com/A8yZSP5.png)

LE LOAD BALANCER

![](https://i.imgur.com/bBNrj7F.png)

LA BDD

![](https://i.imgur.com/iClZJeo.png)
![](https://i.imgur.com/kvOeBMD.png)


COUT TOTAL 

![](https://i.imgur.com/naWD6MF.png)





### Scalway


Dans l'infrastructure Scalway nous allons utiliser:

+ 3 instance 2cpu et 8go de RAM
+ Un Load Balancer
+ Une base de données PostgreSQL de 4vCPU et 16Go de RAMen stand alone avec une storage block de 10Go.

![](https://i.imgur.com/4C0gH3u.png)

Il faut 3 intance qui fait 135,56 € et 134,47$



LOAD BALANCER

![](https://i.imgur.com/ZvQM3Hq.png)

Pour le loadbalancer le coup corresponf à 25,82€ soit 24,44$


LA BDD

![](https://i.imgur.com/gR3dTQy.png)

Pour la base de données managé le coup correspond à 121,96€ soit 120,09$

Le coup total de l'infrastructure couterais 279$ par mois.



### AWS

Pour cette infrastructure la, nous allons utiliser les services : 

+ EC2 : 3 serveurs (4GO RAM, 2vCPU, 50GO de stockage) 
+ Elastic Load Balancing
+ Amazon Aurora MySQL-Compatible


#### *Service EC2*
ATTENTION : PAS DE PLAN DE TARIFICATION
![](https://i.imgur.com/w9qJVFj.png)
Calcul : 
3 instances x 0,0376 USD x 730 heures dans un mois = 82,34 USD (coût mensuel à la demande)
Instances à la demande Amazon EC2 (mensuellement): 82.34 USD

+ Choix région + ressources
![](https://i.imgur.com/DsCVIXi.png)
![](https://i.imgur.com/j7wWldH.png)

+ Choix qté instances
![](https://i.imgur.com/MuFWv6A.png)

+ Choix qté stockage par $$instance
![](https://i.imgur.com/GElY2Cv.png)

Calcul : 
50 Go x 0,116 USD x 3 instances = 17,40 USD (coût de stockage EBS)
Coût de stockage EBS: 17,40 USD
Tarification Amazon Elastic Block Storage (EBS) (mensuellement): 17.40 USD

+ **Coût total mensuel et annuel en USD :**

![](https://i.imgur.com/1WhGyBx.png)



#### *Elastic Load Balancing*

![](https://i.imgur.com/Uksbh4A.png)

![](https://i.imgur.com/Sb5LjdS.png)

![](https://i.imgur.com/U6W5wD5.png)




#### *Base de données*

+ Choix ressources 

![](https://i.imgur.com/AWLhSeh.png)


Calcul : 
1 instance(s) x 0.145 USD horaire x (98 / 100 utilisés/mois) x 730 heures dans un mois = 103.7330 USD
Coût RDS MySQL (mensuellement): 103.73 USD


+ Choix espace de stockage :

![](https://i.imgur.com/pXybg9o.png)


#### *Coût total infra 3 AWS*

![](https://i.imgur.com/kfK1yri.png)



#### GCP

+ #### *3 instances :*

![](https://i.imgur.com/wyAHeCx.png)

+ #### *Load balancing :*

MANQUE SCREENSHOOOOOOOOOOOOT  tu as oublié un O mec fait gaffe stp

+ #### *Base de données managé:*

Pour cela, nous allons utiliser le service : Cloud SQL for MySQL

![](https://i.imgur.com/1IEeGMm.png)



