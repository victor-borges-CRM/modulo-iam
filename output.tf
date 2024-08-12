output "nome_role" {
  value       = aws_iam_instance_profile.perfil_ec2.name
  description = "Nome do perfil de instancia que será importante pelo modulo EC2"
}
