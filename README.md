# Módulo Terraform - Security Group Rules

## Descripción

Este módulo de Terraform permite crear y gestionar reglas de Security Group de AWS de forma modular y reutilizable. 

La principal característica es que **unifica la gestión de reglas de ingress y egress en una única variable**, permitiendo crear, modificar y eliminar reglas de seguridad de manera dinámica y flexible. Utiliza `for_each` para iterar sobre un mapa de reglas, soporta múltiples tipos de fuentes (CIDR blocks, Security Groups, Prefix Lists) y está diseñado para trabajar con provider aliases para deployments multi-cuenta.

**Versión**: 1.0.0

## ✨ Características

- ✅ **Unificado**: Una sola variable para reglas de ingress y egress
- ✅ **Flexible**: Soporte para CIDR blocks, Security Groups y Prefix Lists
- ✅ **Opcional**: Puedes crear solo ingress, solo egress, ambas o ninguna
- ✅ **Provider Alias**: Soporte para multi-account con provider alias
- ✅ **Dinámico**: Uso de `for_each` para gestión dinámica de reglas
- ✅ **Descripciones**: Documentación personalizada por regla

## 🚀 Inicio Rápido

### 1️⃣ Agregar el Módulo

```hcl
module "my_sg_rules" {
  source = "git::https://your-repo.git//path/to/tf-module-sg-rules"
  
  providers = {
    aws.project = aws.principal
  }

  security_group_id = "sg-xxxxx"
  
  security_group_rules = {
    https = {
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS público"
    }
  }
}
```

### 2️⃣ Inicializar y Aplicar

```bash
terraform init
terraform plan
terraform apply
```

### 3️⃣ Ver Outputs

```bash
terraform output
```

## 📖 Uso Básico

```hcl
module "security_group_rules" {
  source = "git::https://tu-repo.git//path/to/tf-module-sg-rules"
  
  providers = {
    aws.project = aws.principal
  }

  security_group_id = "sg-0123456789abcdef0"

  security_group_rules = {
    # Regla de Ingress
    allow_https = {
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS from anywhere"
    }
    
    # Regla de Egress
    allow_outbound = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  }
}
```

## 📥 Variables de Entrada

### `security_group_id` (requerido)
- **Tipo:** `string`
- **Descripción:** ID del Security Group al que se aplicarán las reglas
- **Ejemplo:** `"sg-0123456789abcdef0"`

### `security_group_rules` (opcional)
- **Tipo:** `map(object)`
- **Default:** `{}`
- **Descripción:** Mapa unificado de reglas de Security Group (ingress y egress)

Estructura del objeto:
```hcl
{
  type                     = string                # "ingress" o "egress" (requerido)
  from_port                = number                # Puerto inicial (requerido)
  to_port                  = number                # Puerto final (requerido)
  protocol                 = string                # tcp, udp, icmp, -1 (requerido)
  cidr_blocks              = optional(list(string)) # Lista de CIDRs
  prefix_list_ids          = optional(list(string)) # IDs de Prefix Lists
  source_security_group_id = optional(string)       # ID de Security Group origen/destino
  description              = optional(string)       # Descripción de la regla
}
```

**Nota:** Es completamente opcional. Puedes:
- Crear solo reglas `ingress`
- Crear solo reglas `egress`
- Crear ambas
- No crear ninguna (dejar el mapa vacío)

## Outputs

### `rule_ids`
- **Descripción:** Mapa con los IDs de todas las reglas creadas (ingress y egress)

### `ingress_rule_ids`
- **Descripción:** Mapa con los IDs solo de las reglas de entrada

### `egress_rule_ids`
- **Descripción:** Mapa con los IDs solo de las reglas de salida

### `security_group_id`
- **Descripción:** ID del Security Group al que se aplicaron las reglas

## Ejemplos

Ver el directorio `sample/` para ejemplos completos de uso.

### Ejemplo: Solo Ingress
```hcl
module "sg_web" {
  source            = "path/to/module"
  security_group_id = "sg-123456"
  
  security_group_rules = {
    https = {
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

### Ejemplo: Solo Egress
```hcl
module "sg_app" {
  source            = "path/to/module"
  security_group_id = "sg-789012"
  
  security_group_rules = {
    to_database = {
      type                     = "egress"
      from_port                = 5432
      to_port                  = 5432
      protocol                 = "tcp"
      source_security_group_id = "sg-database"
    }
  }
}
```

### Ejemplo: Sin reglas
```hcl
module "sg_empty" {
  source            = "path/to/module"
  security_group_id = "sg-empty"
  # security_group_rules no se especifica, usa default {}
}
```

## ⚠️ Notas Importantes

1. **Provider Alias:** Este módulo requiere un provider alias `aws.project`
2. **Prefix Lists:** Use `prefix_list_ids` (plural) que acepta una lista de IDs
3. **Security Group ID:** Tanto para ingress como egress use `source_security_group_id`
4. **Protocolo:** Use `-1` para permitir todos los protocolos
5. **Puertos:** Use `0` para `from_port` y `to_port` cuando use protocolo `-1`
6. **Tipo de Regla:** El campo `type` es obligatorio y debe ser `"ingress"` o `"egress"`

## 🔧 Configuración de Providers

Este módulo utiliza **provider alias** para permitir multi-account deployments:

```hcl
# En tu configuración principal
provider "aws" {
  alias   = "principal"
  region  = "us-east-1"
  profile = "your-profile"
}

module "sg_rules" {
  source = "./tf-module-sg-rules"
  
  providers = {
    aws.project = aws.principal
  }
  
  # ... resto de la configuración
}
```

## ✅ Validación

Para validar la configuración sin aplicar cambios:

```bash
# Inicializar
terraform init

# Validar sintaxis
terraform validate

# Ver plan de ejecución
terraform plan

# Aplicar cambios
terraform apply
```

## 📋 Requisitos

| Nombre | Versión |
|--------|---------|
| terraform | >= 1.13.1 |
| aws | >= 5.0 |

## 🏗️ Estructura del Módulo

```
tf-module-sg-rules/
├── README.md              # Documentación principal
├── main.tf                # Recurso principal
├── variables.tf           # Definición de variables
├── outputs.tf             # Outputs del módulo
├── providers.tf           # Configuración de providers
├── local.tf               # Variables locales
├── data.tf                # Data sources (vacío)
└── sample/                # Ejemplos de uso
    ├── main.tf            # Ejemplo principal
    ├── variables.tf       # Variables del ejemplo
    ├── outputs.tf         # Outputs del ejemplo
    ├── providers.tf       # Providers del ejemplo
    ├── terraform.tfvars   # Valores de ejemplo
    └── examples.tf        # Casos de uso adicionales
```
