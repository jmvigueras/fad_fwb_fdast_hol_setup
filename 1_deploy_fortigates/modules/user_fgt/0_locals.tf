#-----------------------------------------------------------------------------------------------------
# FortiGate Terraform deployment
# Active Passive High Availability MultiAZ with AWS Transit Gateway with VPC standard attachment
#-----------------------------------------------------------------------------------------------------
locals {
  #-----------------------------------------------------------------------------------------------------
  # General variables
  #-----------------------------------------------------------------------------------------------------
  fgt_ports = {
    public  = "port1"
    private = "port2"
  }

  #-----------------------------------------------------------------------------------------------------
  # SPOKES 
  #-----------------------------------------------------------------------------------------------------
  spokes_sdwan = { for i, v in range(0, var.number_users) : "${var.spoke_prefix}-user${i + 1}" =>
    {
      id       = "${var.spoke_prefix}-user${i + 1}"
      cidr     = "10.${var.spoke_cidr_net}.${i + 1}.0/24"
      bgp_asn  = var.bgp_asn
      xpert_id = "fortixpert${((tonumber(substr(var.spoke_prefix, -1, -1)) - 1) * var.number_users) + i + 1}"
    }
  }
  hubs = var.vpn_hubs
}