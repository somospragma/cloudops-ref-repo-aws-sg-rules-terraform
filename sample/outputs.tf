###########################################
# Outputs Example for Security Group Rules
###########################################
output "all_rules" {
  description = "Todos los IDs de reglas creadas"
  value       = module.sg_rules_example.rule_ids
}

output "ingress_rules" {
  description = "Solo reglas de ingress"
  value       = module.sg_rules_example.ingress_rule_ids
}

output "egress_rules" {
  description = "Solo reglas de egress"
  value       = module.sg_rules_example.egress_rule_ids
}
