variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_id" {
  
}

variable "frr_vm_name" {
  description = "frr VM name"
  default = "frr"
}

variable "key_name" {
  description = "EC2 ssh key name"  
}

variable "tags" {
  description = "Provide additional tags"
  default     = {}
  type        = map(string)
}

locals {
  description = "By default, VM name will be added. Additional tags will be merge with the VM name tag"
  tags = merge(
    {
      Name = var.frr_vm_name
    },
    var.tags
  )
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Provide instance type"
}

variable "mtt_transit_object" {
  
}

variable "frr_as_num" {
  
}

variable "transit_bgp_lan_ip" {
  
}
variable "transit_as_num" {
  
}

variable "loopback_ip" {
  
}
variable "loopback_cidr" {
  
}