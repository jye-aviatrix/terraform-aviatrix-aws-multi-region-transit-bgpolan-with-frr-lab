locals {
  frr_subnet_cidr = cidrsubnets(var.transit_cidr,1,5)
}

resource "aws_subnet" "frr" {
  vpc_id     = module.mc-transit.vpc.vpc_id
  cidr_block = local.frr_subnet_cidr[1]
  availability_zone = "${module.mc-transit.vpc.region}${module.mc-transit.mc_firenet_details.az1}"

  tags = {
    Name = "frr-subnet"
  }
}

data "aws_internet_gateway" "this" {
  filter {
    name   = "attachment.vpc-id"
    values = [module.mc-transit.vpc.vpc_id]
  }
}

resource "aws_route_table" "frr" {
  vpc_id = module.mc-transit.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.this.id
  }
  tags = {
    Name = "frr-rtb"
  }
}


resource "aws_route_table_association" "frr" {
  subnet_id      = aws_subnet.frr.id
  route_table_id = aws_route_table.frr.id
}

module "frr" {
  source = "../frr"
  vpc_id = module.mc-transit.vpc.vpc_id
  subnet_id = aws_subnet.frr.id
  key_name = var.key_name
  mtt_transit_object = module.mc-transit
  frr_as_num = var.frr_as_num
  transit_bgp_lan_ip = cidrhost(local.frr_subnet_cidr[1],14)
  transit_as_num = module.mc-transit.transit_gateway.local_as_number
  loopback_ip = var.loopback_ip
  loopback_cidr = var.loopback_cidr
}