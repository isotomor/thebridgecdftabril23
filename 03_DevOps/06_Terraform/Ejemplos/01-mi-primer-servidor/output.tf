output "dns_publica" {
  descripcion = "DNS pública del servidor"
  value = "http://$(aws_instance.mi_servidor.public_dns}:8080"
}