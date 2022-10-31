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


######GATEWAY#######
resource “scaleway_vpc_private_network” “pn01” {
name = “pn_test_network”
}

resource “scaleway_vpc_public_gateway_ip” “gw01” {
}

resource “scaleway_vpc_public_gateway_dhcp” “dhcp01” {
subnet = “192.168.1.0/24”
push_default_route = true
}

resource “scaleway_vpc_public_gateway” “pg01” {
name = “foobar”
type = “VPC-GW-S”
ip_id = scaleway_vpc_public_gateway_ip.gw01.id
}

resource “scaleway_vpc_gateway_network” “main” {
gateway_id = scaleway_vpc_public_gateway.pg01.id
private_network_id = scaleway_vpc_private_network.vpc01.id
dhcp_id = scaleway_vpc_public_gateway_dhcp.dhcp01.id
cleanup_dhcp = true
enable_masquerade = true
}
