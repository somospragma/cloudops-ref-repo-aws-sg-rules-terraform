###########################################
#Variable Globales
###########################################
variable "aws_region" {
  description = "La región de AWS donde se crearán los recursos."
  type        = string
}

variable "profile" {
  description = "Profile account AWS"
  type        = string
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to be applied to the resources"
}

###########################################
#Variable Rules SG 
###########################################
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

variable "security_group_id" {
  description = "Security Group"
  type        = string
}