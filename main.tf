# modules/security_group_rules/main.tf

# Reglas de Security Group (Ingress y Egress unificadas)
resource "aws_security_group_rule" "this" {
  provider = aws.project
  for_each = var.security_group_rules

  type              = each.value.type
  security_group_id = var.security_group_id

  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  description = try(each.value.description, null)

  # Atributos opcionales (válidos para ingress y egress)
  cidr_blocks              = try(each.value.cidr_blocks, null)
  prefix_list_ids          = try(each.value.prefix_list_ids, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
}
