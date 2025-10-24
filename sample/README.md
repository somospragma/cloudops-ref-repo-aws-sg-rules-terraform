# Ejemplos de Uso - Security Group Rules Module

## Descripción

Este directorio contiene ejemplos prácticos y funcionales de cómo utilizar el módulo `tf-module-sg-rules`.

Los ejemplos demuestran diferentes escenarios de uso: creación de reglas de ingress, egress, combinación de ambas, uso de CIDR blocks, Security Groups como fuente/destino, y configuración de provider aliases. Cada archivo incluye comentarios detallados y valores de ejemplo que puedes adaptar a tu infraestructura.

## 📁 Archivos en este Directorio

- **`main.tf`** - Ejemplo principal de uso del módulo
- **`variables.tf`** - Definición de variables para los ejemplos
- **`outputs.tf`** - Outputs que muestran los resultados
- **`providers.tf`** - Configuración de providers AWS
- **`terraform.tfvars`** - Valores de ejemplo para las variables
- **`examples.tf`** - Casos de uso adicionales

## 🚀 Cómo Usar estos Ejemplos

### 1. Configurar las Variables

Edita el archivo `terraform.tfvars` con tus valores:

```hcl
aws_region = "us-east-1"
profile    = "tu-perfil-aws"

security_group_id = "sg-xxxxxxxxxxxxxxxxx"  # Tu Security Group ID

security_group_rules = {
  allow_https = {
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir HTTPS"
  }
}
```

### 2. Inicializar Terraform

```bash
cd sample/
terraform init
```

### 3. Validar la Configuración

```bash
terraform validate
terraform plan
```

### 4. Aplicar los Cambios

```bash
terraform apply
```

### 5. Destruir los Recursos (cuando termines)

```bash
terraform destroy
```

## 📋 Ejemplos Incluidos

### Ejemplo 1: Reglas Mixtas (main.tf)

Muestra cómo crear reglas de ingress y egress en un solo módulo:

```hcl
security_group_rules = {
  allow_https = {
    type                     = "ingress"
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    source_security_group_id = "sg-xxxxx"
    description              = "HTTPS desde otro SG"
  }
  allow_to_rds = {
    type                     = "egress"
    from_port                = 3306
    to_port                  = 3306
    protocol                 = "tcp"
    source_security_group_id = "sg-xxxxx"
    description              = "Conexión a RDS"
  }
}
```

### Ejemplo 2: Solo Ingress (examples.tf)

```hcl
security_group_rules = {
  web_traffic = {
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
    description = "HTTPS desde red interna"
  }
}
```

### Ejemplo 3: Solo Egress (examples.tf)

```hcl
security_group_rules = {
  database_access = {
    type                     = "egress"
    from_port                = 5432
    to_port                  = 5432
    protocol                 = "tcp"
    source_security_group_id = "sg-database"
    description              = "Acceso a PostgreSQL"
  }
}
```

### Ejemplo 4: Con Prefix Lists (examples.tf)

```hcl
security_group_rules = {
  s3_access = {
    type            = "egress"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    prefix_list_ids = ["pl-12345678"]
    description     = "Acceso a S3"
  }
}
```

### Ejemplo 5: Sin Reglas (examples.tf)

```hcl
# No especificar security_group_rules o usar {}
security_group_rules = {}
```

## 🎯 Casos de Uso Comunes

### Web Application (HTTP/HTTPS)

```hcl
security_group_rules = {
  http = {
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP público"
  }
  https = {
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS público"
  }
  outbound = {
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Todo el tráfico saliente"
  }
}
```

### Database Access (MySQL/PostgreSQL)

```hcl
security_group_rules = {
  mysql_from_app = {
    type                     = "ingress"
    from_port                = 3306
    to_port                  = 3306
    protocol                 = "tcp"
    source_security_group_id = "sg-app-servers"
    description              = "MySQL desde servidores de aplicación"
  }
}
```

### SSH Bastion Access

```hcl
security_group_rules = {
  ssh_from_bastion = {
    type                     = "ingress"
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    source_security_group_id = "sg-bastion"
    description              = "SSH solo desde bastion"
  }
}
```

### VPC Endpoint (S3, DynamoDB)

```hcl
security_group_rules = {
  s3_endpoint = {
    type            = "egress"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    prefix_list_ids = ["pl-xxxxxxxx"]  # S3 prefix list
    description     = "Acceso a S3 via VPC Endpoint"
  }
}
```

## 🔍 Ver los Resultados

Después de aplicar, puedes ver los outputs:

```bash
# Ver todos los outputs
terraform output

# Ver un output específico
terraform output all_rules
terraform output ingress_rules
terraform output egress_rules
```

## 🐛 Troubleshooting

### Error: Invalid Security Group ID

Asegúrate de que el `security_group_id` exista en la región configurada.

### Error: Invalid CIDR block

Verifica que los CIDR blocks tengan el formato correcto (ej: `10.0.0.0/16`).

### Error: Invalid type

El campo `type` debe ser exactamente `"ingress"` o `"egress"`.

### Error: Provider configuration

Asegúrate de que el provider alias esté correctamente configurado:

```hcl
providers = {
  aws.project = aws.principal
}
```

## 📞 Soporte

Para más información, consulta el README principal del módulo o revisa los comentarios en los archivos de ejemplo.

## ✅ Checklist Antes de Aplicar

- [ ] Variables configuradas en `terraform.tfvars`
- [ ] Security Group ID válido
- [ ] Región AWS correcta
- [ ] Profile AWS configurado
- [ ] Provider alias configurado
- [ ] `terraform validate` ejecutado sin errores
- [ ] `terraform plan` revisado

## 🎓 Mejores Prácticas

1. **Descripción Clara**: Siempre incluye descripciones significativas para cada regla
2. **Principio de Mínimo Privilegio**: Solo abre los puertos necesarios
3. **CIDR Específicos**: Evita usar `0.0.0.0/0` cuando sea posible
4. **Security Groups sobre CIDRs**: Prefiere `source_security_group_id` para comunicación interna
5. **Tags Apropiados**: Usa `common_tags` para identificar recursos
6. **Versionado**: Documenta cambios en las reglas de seguridad

---

**🔐 Recuerda:** Las reglas de Security Group son críticas para la seguridad. Siempre revisa los cambios antes de aplicarlos.
