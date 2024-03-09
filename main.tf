module "region1" {
  source           = "./modules/region"
  account          = var.account
  region           = "us-east-1"
  cloud            = var.cloud
  transit_cidr     = "10.16.0.0/23"
  local_as_number  = 65016
  transit_gw_name  = "ue1transit"
  transit_vpc_name = "ue1transit"
  ha_gw            = var.ha_gw
  providers = {
    aws = aws.ue1
  }
  key_name       = var.key_name
  spoke_vpc_name = "ue1spoke1"
  spoke_gw_name  = "ue1spoke1"
  spoke_cidr     = "10.16.100.0/24"
  frr_as_num     = 65116
  loopback_ip    = "16.16.16.16/24"
  loopback_cidr  = "16.16.16.0/24"
}

module "region2" {
  source           = "./modules/region"
  account          = var.account
  region           = "us-east-2"
  cloud            = var.cloud
  transit_cidr     = "10.32.0.0/23"
  local_as_number  = 65032
  transit_gw_name  = "ue2transit"
  transit_vpc_name = "ue2transit"
  ha_gw            = var.ha_gw
  providers = {
    aws = aws.ue2
  }
  key_name       = var.key_name
  spoke_vpc_name = "ue2spoke1"
  spoke_gw_name  = "ue2spoke1"
  spoke_cidr     = "10.32.100.0/24"
  frr_as_num     = 65132
  loopback_ip    = "32.32.32.32/24"
  loopback_cidr  = "32.32.32.0/24"
}

module "region3" {
  source           = "./modules/region"
  account          = var.account
  region           = "us-west-1"
  cloud            = var.cloud
  transit_cidr     = "10.64.0.0/23"
  local_as_number  = 65064
  transit_gw_name  = "uw1transit"
  transit_vpc_name = "uw1transit"
  ha_gw            = var.ha_gw
  providers = {
    aws = aws.uw1
  }
  key_name       = var.key_name
  spoke_vpc_name = "uw1spoke1"
  spoke_gw_name  = "uw1spoke1"
  spoke_cidr     = "10.64.100.0/24"
  frr_as_num     = 65164
  loopback_ip    = "64.64.64.64/24"
  loopback_cidr  = "64.64.64.0/24"
}
