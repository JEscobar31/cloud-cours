# TP Scaleway Terraform, Sécurité et Réseaux

Installation de l'env terraform avec linux : 

> wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

> echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

> sudo apt update && sudo apt install terraform


Configurer le provider Scaleway (project id + region): 

tp02.tf
```
variable "project_id" {
  type        = string
  description = "Project ID du groupe 9"
  default     = "2ff177fd-3df2-472e-8021-0e3022fb7930"
}

terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"
}
```

Vous installez une base de données MySQL à l’aide du service correspondant sur
Scaleway. Connectez-vous à la base de données et réalisez quelques opérations basiques.


```
resource "scaleway_rdb_instance" "main" {
  name           = "tp02-rdb-groupe9"
  node_type      = "DB-DEV-S"
  engine         = "MySQL-8"
  is_ha_cluster  = false
  disable_backup = true
  user_name      = "groupe9"
  password       = "Groupe99?"
}

```



> terraform init

> terraform plan

```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

* Afficher la liste des BDD sur le project-id (groupe 9)

> scw  rdb instance list project-id=2ff177fd-3df2-472e-8021-0e3022fb7930

* Commande pour récupérer des information sur la bdd comme l'adrresse IP/Port

> scw  rdb instance get 6ceb0406-39f7-4bb6-b015-14ff59732c2e




* Quelques opérations mysql :

```
mysql> create database users;
mysql> use users;
mysql> create table user (nom varchar(255),prenom varchar(255));
mysql> insert into user values ("bg","bg");
```

* Créer une instance dans le Cloud Scaleway de type DEV1_S, connectez vous au serveur en SSH et installer netcat et telnet.

> lien utile : https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_server

```
resource "scaleway_instance_ip" "public_ip" {}
resource "scaleway_instance_server" "web" {
  type = "DEV1-S"
  image = "ubuntu_jammy"
  ip_id = scaleway_instance_ip.public_ip.id
}
```

 >scw  instance server list project-id=2ff177fd-3df2-472e-8021-0e3022fb7930

>scw  instance server get 6b616f37-4868-4e2b-9365-3e205d5f8b36

>ssh root@163.172.173.195

>apt install telnet && apt install netcat

* A ce stade, aucune règle de sécurité, vous pouvez accéder à la base de données (port 3306), au serveur en SSH (port 22) ou à un éventuel serveur web (port 80 - HTTP). Vérifier cela avec les commandes netcat et telnet.


Effectivement les ports fonctionnent


* A l’aide des security groups, vous ouvrez au monde entier seulement l’accès HTTP. Bloquer les accès SSH à votre machine uniquement depuis votre IP, et les accès à la base de données seulement depuis le serveur


```

resource "scaleway_instance_ip" "public_ip" {}
resource "scaleway_instance_server" "web" {
  type = "DEV1-S"
  image = "ubuntu_jammy"
  ip_id = scaleway_instance_ip.public_ip.id
}

resource "scaleway_instance_security_group" "web" {
  inbound_default_policy  = "drop" # By default we drop incoming traffic that do not match any inbound_rule.
  outbound_default_policy = "drop" # By default we drop outgoing traffic that do not match any outbound_rule.


  inbound_rule {
    action = "accept"
    port   = 80
  }

  inbound_rule {
    action = "accept"
    port   = 22
    ip     = "85.169.101.162"
  }

  outbound_rule {
    action = "accept"
    ip     = "8.8.8.8" # Only allow outgoing connection to this IP. (google c'est toujours pratique)
  }
}

```

>ssh: connect to host 163.172.173.195 port 22: Connection refused

```
resource "scaleway_rdb_acl" "main" {
  instance_id = scaleway_rdb_instance.main.id
  acl_rules {
    ip = "163.172.173.195/32"
  }
}
```


# Cas n°2 :

* Créer deux VPC. L’un contient deux machines et l’autre une seule. Utiliser les boucles dans Terraform avec le paramètre count.

```
variable "project_id" {
  type        = string
  description = "Project ID du groupe 9"
  default     = "2ff177fd-3df2-472e-8021-0e3022fb7930"
}

terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"
}

####################################################
################VPC01 : PRIVATE NETWORK#############
####################################################


resource scaleway_vpc_private_network vpc01 {
    name = "private_network_instance"
}

resource "scaleway_instance_server" "base" {
  image = "ubuntu_jammy"
  type  = "DEV1-S"
  count = 2
  name = "Groupe9_vpc1_${count.index + 1}"

  private_network {
    pn_id = scaleway_vpc_private_network.vpc01.id
  }
}

####################################################
################VPC01 : PUBLIC NETWORK##############
####################################################

resource "scaleway_instance_ip" "public_ip" {}
resource "scaleway_instance_server" "www" {
  image = "ubuntu_jammy"
  type  = "DEV1-S"
  count = 1
  name = "Groupe9_vpc1_${count.index + 1}_IP_Publique"
  ip_id = scaleway_instance_ip.public_ip.id


  private_network {
    pn_id = scaleway_vpc_private_network.vpc01.id
  }
}

####################################################
################VPC02 : PRIVATE NETWORK#############
####################################################

resource scaleway_vpc_private_network vpc02 {
    name = "private_network_instance"
}

resource "scaleway_instance_server" "web" {
  image = "ubuntu_jammy"
  type  = "DEV1-S"
  name = "Groupe9_vpc2_${count.index + 1}"
  count = 1

  private_network {
    pn_id = scaleway_vpc_private_network.vpc02.id
  }
}
```

* Vérifier avec telnet et netcat que les machines dans un même VPC peuvent communiquer sur n’importe quel port. A l’inverse vérifier que ce n’est pas possible pour des machines qui ne sont pas sur le même VPC

Au final 

* Installation de la gateway 

```
resource "scaleway_vpc_private_network" "pn01" {
  name = "pn_test_network"
}

resource "scaleway_vpc_public_gateway_ip" "gw01" {
}

resource "scaleway_vpc_public_gateway_dhcp" "dhcp01" {
  subnet = "192.168.1.0/24"
  push_default_route = true
}

resource "scaleway_vpc_public_gateway" "pg01" {
  name = "foobar"
  type = "VPC-GW-S"
  ip_id = scaleway_vpc_public_gateway_ip.gw01.id
}

resource "scaleway_vpc_gateway_network" "main" {
  gateway_id = scaleway_vpc_public_gateway.pg01.id
  private_network_id = scaleway_vpc_private_network.vpc01.id
  dhcp_id = scaleway_vpc_public_gateway_dhcp.dhcp01.id
  cleanup_dhcp       = true
  enable_masquerade  = true
}
```






