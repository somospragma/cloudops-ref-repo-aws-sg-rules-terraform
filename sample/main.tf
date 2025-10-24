###########################################
# Module Example for Security Group Rules
###########################################

module "sg_rules_example" {
  source = "../"
  providers = {
    aws.project = aws.principal
  }

  security_group_id    = var.security_group_id
  security_group_rules = var.security_group_rules
}