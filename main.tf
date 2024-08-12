data "aws_iam_role" "importa_funcao_iam" {
  name = "PermiteSSMGenrenciarEC2"
}

resource "aws_iam_instance_profile" "perfil_ec2" {
  name = "test_perfil_ec2"
  role = data.aws_iam_role.importa_funcao_iam.name
}