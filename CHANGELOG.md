# Changelog

Todos los cambios notables en este módulo serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [1.0.0] - 2025-10-23

### ✨ Agregado
- Módulo inicial de Security Group Rules
- Soporte para reglas de ingress y egress unificadas en una sola variable
- Configuración mediante CIDR blocks
- Configuración mediante Security Groups (source_security_group_id)
- Soporte para Prefix Lists
- Provider alias para multi-account deployments
- Variables locales para separar y contar reglas por tipo
- Outputs para todas las reglas, solo ingress, y solo egress
- Documentación completa en README.md
- Ejemplos de uso en directorio sample/
- Archivo .gitignore
- Variables opcionales con valores por defecto

### 🔧 Características
- Uso de `for_each` para gestión dinámica de reglas
- Soporte para descripciones personalizadas por regla
- Validación de tipos mediante Terraform
- Compatible con Terraform >= 1.13.1
- Compatible con AWS Provider >= 5.0

### 📚 Documentación
- README principal con ejemplos
- README en directorio sample/
- Archivo EXAMPLES.md con 10 casos de uso
- Comentarios detallados en terraform.tfvars
- Estructura del proyecto documentada

### 🎯 Casos de Uso Soportados
- Web Applications (ALB/NLB)
- Database Servers (RDS, ElastiCache)
- Bastion Hosts / Jump Servers
- Microservicios
- VPC Endpoints
- Lambda Functions
- ECS/EKS Workloads

---

## Formato de Versiones

### [MAJOR.MINOR.PATCH]

- **MAJOR**: Cambios incompatibles con versiones anteriores
- **MINOR**: Nueva funcionalidad compatible con versiones anteriores
- **PATCH**: Correcciones de bugs compatibles con versiones anteriores

### Tipos de Cambios

- **✨ Agregado**: Para nuevas características
- **🔧 Cambiado**: Para cambios en funcionalidad existente
- **❌ Deprecado**: Para características que serán removidas
- **🗑️ Removido**: Para características removidas
- **🐛 Corregido**: Para corrección de bugs
- **🔒 Seguridad**: Para vulnerabilidades de seguridad

---

## Roadmap Futuro

### [1.1.0] - Planificado
- [ ] Soporte para IPv6 (ipv6_cidr_blocks)
- [ ] Soporte para self-reference rules
- [ ] Validación de conflictos entre reglas
- [ ] Outputs adicionales con métricas de reglas

### [1.2.0] - En Consideración
- [ ] Plantillas predefinidas para casos comunes
- [ ] Validación de puertos comunes
- [ ] Generación automática de descripciones
- [ ] Integración con AWS Systems Manager Parameter Store

---

## Contribuciones

Para contribuir a este módulo:

1. Crea un branch desde `main`
2. Realiza tus cambios
3. Actualiza este CHANGELOG.md
4. Crea un Pull Request
5. Espera la revisión del equipo

## Contacto

- **Equipo**: Chapter CloudOps
- **Fecha de Creación**: Octubre 2025
