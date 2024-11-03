# Create LAB dual HUB
module "hub_fgsp_tgw" {
  source = "./modules/hub_fgsp_tgw"

  rsa_public_key = trimspace(tls_private_key.ssh.public_key_openssh)
  api_key        = trimspace(random_string.api_key.result)
  key_pair_name  = aws_key_pair.hub_keypair.key_name
  instance_type  = local.fgt_instance_type
  fgt_build      = local.fgt_build_745

  region = local.hub_region["id"]
  azs    = [local.hub_region["az1"], local.hub_region["az2"]]
  prefix = local.prefix

  app_external_port   = local.lab_server_external_port
  app_mapped_port     = local.lab_server_mapped_port
  redis_external_port = local.redis_external_port
  redis_mapped_port   = local.redis_mapped_port

  route53_zone_name = local.route53_zone_name

  hub_1_vpc_cidr           = local.hub_1_vpc_cidr
  hub_1_spoke_to_tgw_cidrs = local.hub_1_spoke_to_tgw_cidrs

  hub_1_dns_record = local.hub_1_dns_record

  vpn_hub_1 = local.hub_1

  access_key = var.access_key
  secret_key = var.secret_key
}