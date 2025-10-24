# outputs.tf

output "rule_ids" {
  description = "IDs de todas las reglas creadas (ingress y egress)"
  value       = { for k, v in aws_security_group_rule.this : k => v.id }
}

output "ingress_rule_ids" {
  description = "IDs de todas las reglas de entrada creadas"
  value       = { for k, v in aws_security_group_rule.this : k => v.id if v.type == "ingress" }
}

output "egress_rule_ids" {
  description = "IDs de todas las reglas de salida creadas"
  value       = { for k, v in aws_security_group_rule.this : k => v.id if v.type == "egress" }
}

output "security_group_id" {
  description = "ID del Security Group al que se aplicaron las reglas"
  value       = var.security_group_id
}
