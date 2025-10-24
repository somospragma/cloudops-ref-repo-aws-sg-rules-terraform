###########################################
#Variable Rules SG 
###########################################

variable "security_group_id" {
  description = "El ID del Security Group al que se aplicarán las reglas."
  type        = string
}

variable "security_group_rules" {
  description = "Mapa de reglas de Security Group (Ingress y Egress) a aplicar."
  type = map(object({
    type                     = string # "ingress" o "egress"
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    prefix_list_ids          = optional(list(string))
    source_security_group_id = optional(string)
    description              = optional(string)
  }))
  default = {}
}