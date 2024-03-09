# # Create an Aviatrix Transit External Device Connection
# resource "aviatrix_transit_external_device_conn" "to_frr" {
#   vpc_id            = var.mtt_transit_object.vpc.vpc_id
#   connection_name   = "${var.mtt_transit_object.transit_gateway.gw_name}-to-frr"
#   gw_name           = var.mtt_transit_object.transit_gateway.gw_name
#   connection_type   = "bgp"
#   bgp_local_as_num  = var.mtt_transit_object.transit_gateway.local_as_number
#   bgp_remote_as_num = var.frr_as_num
#   remote_gateway_ip = aws_instance.this.private_ip
#   tunnel_protocol   = "LAN"
# }


resource "aviatrix_transit_external_device_conn" "transit_external_device_conn_1" {
    vpc_id = var.mtt_transit_object.vpc.vpc_id
    connection_name = "${var.mtt_transit_object.transit_gateway.gw_name}-to-frr"
    gw_name = var.mtt_transit_object.transit_gateway.gw_name
    connection_type = "bgp"
    direct_connect = false
    bgp_local_as_num = var.mtt_transit_object.transit_gateway.local_as_number
    bgp_remote_as_num = var.frr_as_num
    tunnel_protocol = "LAN"
    remote_lan_ip = aws_instance.this.private_ip
    local_lan_ip = var.transit_bgp_lan_ip
    custom_algorithms = false
    enable_edge_segmentation = false
    phase1_local_identifier = null
}

