module "mc-transit" {
  source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version = "2.5.3"
  # insert the 3 required variables here
  account = var.account
  region  = var.region
  cloud   = var.cloud
  cidr    = var.transit_cidr
  ha_gw   = var.ha_gw
  name    = var.transit_vpc_name
  gw_name = var.transit_gw_name
  local_as_number = var.local_as_number
  instance_size = "c5.4xlarge"
  enable_advertise_transit_cidr = true
}


module "mc-spoke" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.8"
  # insert the 4 required variables here
  account = var.account
  region = var.region
  cloud = var.cloud
  cidr = var.spoke_cidr
  ha_gw = var.ha_gw
  name = var.spoke_vpc_name
  gw_name = var.spoke_gw_name
  transit_gw = module.mc-transit.transit_gateway.gw_name
}