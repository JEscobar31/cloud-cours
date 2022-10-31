variable "project_id" {
  type        = string
  description = "projet id"
  default = "2ff177fd-3df2-472e-8021-0e3022fb7930"
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

resource "scaleway_rdb_instance" "main" {
  name           = "tp2-rdb"
  node_type      = "DB-DEV-S"
  engine         = "MySQL-8"
  is_ha_cluster  = false
  disable_backup = true
  user_name      = "groupe9"
  password       = "Groupe99?"
}

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


resource "scaleway_rdb_acl" "main" {
  instance_id = scaleway_rdb_instance.main.id
  acl_rules {
    ip = "163.172.173.195/32"
  }
}
