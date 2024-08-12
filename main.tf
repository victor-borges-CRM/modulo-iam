data "aws_iam_role" "importa_funcao_iam" {
  name = var.nome_role_iam
}

resource "aws_iam_instance_profile" "perfil_ec2" {
  name = var.nome_instance_profile
  role = data.aws_iam_role.importa_funcao_iam.name
}