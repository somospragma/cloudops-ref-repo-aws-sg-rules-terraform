###########################################
# Local Values para procesamiento
###########################################

locals {
  # Separar reglas por tipo para análisis si es necesario
  ingress_rules = {
    for key, rule in var.security_group_rules :
    key => rule if rule.type == "ingress"
  }

  egress_rules = {
    for key, rule in var.security_group_rules :
    key => rule if rule.type == "egress"
  }

  # Contadores
  total_rules   = length(var.security_group_rules)
  ingress_count = length(local.ingress_rules)
  egress_count  = length(local.egress_rules)
}
