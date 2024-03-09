data "aws_ami" "ubuntu_20_04_lts" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

data "http" "ip" {
  url = "https://ifconfig.me"
}

resource "aws_security_group" "this" {
  name        = "${var.frr_vm_name} allow inbound HTTP(*) SSH(EgressIP), PING(RFC1918)"
  description = "${var.frr_vm_name} allow inbound HTTP from anywhere, SSH from your egress public IP, and ping from RFC 1918"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.http.ip.response_body}/32"]
  }

  ingress {
    description      = "Allow_All_In_Bound_172_12"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = ["172.16.0.0/12"]
  }

    ingress {
    description      = "Allow_All_In_Bound_192_16"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = ["192.168.0.0/16"]
  }

    ingress {
    description      = "Allow_All_In_Bound_10_8"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }


  egress {
    description      = "Allow_All_Out_Bound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.tags
}

resource "aws_network_interface" "this" {
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.this.id]
  source_dest_check = false

  tags = local.tags
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu_20_04_lts.id
  instance_type = var.instance_type

  network_interface {
    network_interface_id = aws_network_interface.this.id
    device_index         = 0
  }

  key_name = var.key_name
  tags     = local.tags

    user_data = base64encode(templatefile("${path.module}/cloud-init.yaml",{
      frr_as_num = var.frr_as_num,
      transit_bgp_lan_ip = var.transit_bgp_lan_ip,
      transit_as_num = var.transit_as_num,
      loopback_ip = var.loopback_ip,
      loopback_cidr = var.loopback_cidr
    }))
}


resource "aws_eip" "this" {
  domain = "vpc"

  instance = aws_instance.this.id
  tags     = local.tags
}


