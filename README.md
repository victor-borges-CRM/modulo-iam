# modulo-iam
Repositório destinado ao recurso IAM da AWS

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.62.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.perfil_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.importa_funcao_iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nome_instance_profile"></a> [nome\_instance\_profile](#input\_nome\_instance\_profile) | Nome da funcao IAM a ser importada | `string` | `"Default_TF"` | no |
| <a name="input_nome_role_iam"></a> [nome\_role\_iam](#input\_nome\_role\_iam) | Nome da funcao IAM a ser importada | `string` | `"Default_TF"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nome_role"></a> [nome\_role](#output\_nome\_role) | Nome do perfil de instancia que será importante pelo modulo EC2 |
<!-- END_TF_DOCS -->