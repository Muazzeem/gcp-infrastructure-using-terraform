module "tgw-us-east-1" {
  source          = "terraform-aws-modules/transit-gateway/aws"
  version         = "1.1.0"
  name            = "tgw-example-us-east-1"
  description     = "TGW example shared with several other AWS accounts"
  amazon_side_asn = "64512"

  enable_auto_accept_shared_attachments = true
  ram_allow_external_principals         = true

  tags = {
    Purpose = "tgw example"
  }
}

module "cb-us-east-1" {
  source             = "github.com/spotify/terraform-google-aws-hybrid-cloud-vpn"
  transit_gateway_id = module.tgw-us-east-1.this_ec2_transit_gateway_id
  google_network     = default
  amazon_side_asn    = 64512
  google_side_asn    = 65534
}