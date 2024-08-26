#===========================================================================
#Criando Policy
#===========================================================================

resource "aws_iam_policy" "politica_ssm_ec2" {
  name        = var.nome_policy_iam
  description = "Politica que permite administrar as frotas de maquinas pelo"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "ssm:UpdateServiceSetting",
          "kms:GenerateDataKey",
          "ssm:ResetServiceSetting"
        ],
        "Resource" : [
          "arn:aws:kms:us-east-1:339713193119:key/e3f23bec-9405-46a1-8fd4-e3751c240bcd",
          "arn:aws:ssm:us-east-1:339713193119:servicesetting/ssm/managed-instance/default-ec2-instance-management-role"
        ]
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : [
          "ssm:SendCommand",
          "ec2:DescribeInstances",
          "ec2:DeleteTags",
          "ssm:DescribeInstancePatches",
          "ssm:TerminateSession",
          "ssm:ResetServiceSetting",
          "ssm:StartSession",
          "scheduler:*",
          "ssm:RemoveTagsFromResource",
          "ssm:DescribeInstancePatchStates",
          "ssm:AddTagsToResource",
          "ssm:GetDocument",
          "ssm:GetInventorySchema",
          "ssm:DescribeInstanceAssociationsStatus",
          "ssm:DescribeInstanceProperties",
          "ssm:ListInventoryEntries",
          "ssm:ListComplianceItems",
          "ec2:DescribeTags",
          "ec2:CreateTags",
          "ssm:GetCommandInvocation",
          "ssm:UpdateServiceSetting",
          "ssm:StartAutomationExecution",
          "ssm:DescribeInstanceInformation",
          "ssm:ListTagsForResource",
          "kms:GenerateDataKey",
          "ssm:GetServiceSetting",
          "ssm:ListCommandInvocations",
          "ssm:ListAssociations",
          "ssm:ListCommands",
          "ssm:SendCommand",
          "ssm:GetCommandInvocation"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "VisualEditor2",
        "Effect" : "Allow",
        "Action" : [
          "ssm:SendCommand",
          "ssm:GetDocument"
        ],
        "Resource" : [
          "arn:aws:ssm:*:339713193119:document/SSM-SessionManagerRunShell",
          "arn:aws:ssm:*:*:document/AWS-PasswordReset",
          "arn:aws:ssm:*:*:document/AWSFleetManager-AddUsersToGroups",
          "arn:aws:ssm:*:*:document/AWSFleetManager-CopyFileSystemItem",
          "arn:aws:ssm:*:*:document/AWSFleetManager-CreateDirectory",
          "arn:aws:ssm:*:*:document/AWSFleetManager-CreateGroup",
          "arn:aws:ssm:*:*:document/AWSFleetManager-CreateUser",
          "arn:aws:ssm:*:*:document/AWSFleetManager-CreateUserInteractive",
          "arn:aws:ssm:*:*:document/AWSFleetManager-CreateWindowsRegistryKey",
          "arn:aws:ssm:*:*:document/AWSFleetManager-DeleteFileSystemItem",
          "arn:aws:ssm:*:*:document/AWSFleetManager-DeleteGroup",
          "arn:aws:ssm:*:*:document/AWSFleetManager-DeleteUser",
          "arn:aws:ssm:*:*:document/AWSFleetManager-DeleteWindowsRegistryKey",
          "arn:aws:ssm:*:*:document/AWSFleetManager-DeleteWindowsRegistryValue",
          "arn:aws:ssm:*:*:document/AWSFleetManager-GetDiskInformation",
          "arn:aws:ssm:*:*:document/AWSFleetManager-GetFileContent",
          "arn:aws:ssm:*:*:document/AWSFleetManager-GetFileSystemContent",
          "arn:aws:ssm:*:*:document/AWSFleetManager-GetGroups",
          "arn:aws:ssm:*:*:document/AWSFleetManager-GetPerformanceCounters",
          "arn:aws:ssm:*:*:document/AWSFleetManager-GetProcessDetails",
          "arn:aws:ssm:*:*:document/AWSFleetManager-GetUsers",
          "arn:aws:ssm:*:*:document/AWSFleetManager-GetWindowsEvents",
          "arn:aws:ssm:*:*:document/AWSFleetManager-GetWindowsRegistryContent",
          "arn:aws:ssm:*:*:document/AWSFleetManager-MountVolume",
          "arn:aws:ssm:*:*:document/AWSFleetManager-MoveFileSystemItem",
          "arn:aws:ssm:*:*:document/AWSFleetManager-RemoveUsersFromGroups",
          "arn:aws:ssm:*:*:document/AWSFleetManager-RenameFileSystemItem",
          "arn:aws:ssm:*:*:document/AWSFleetManager-SetWindowsRegistryValue",
          "arn:aws:ssm:*:*:document/AWSFleetManager-StartProcess",
          "arn:aws:ssm:*:*:document/AWSFleetManager-TerminateProcess",
          "arn:aws:ssm:*:339713193119:managed-instance/*",
          "arn:aws:ec2:*:339713193119:instance/*"
        ],
        "Condition" : {
          "BoolIfExists" : {
            "ssm:SessionDocumentAccessCheck" : "false"
          }
        }
      },
      {
        "Sid" : "VisualEditor3",
        "Effect" : "Allow",
        "Action" : [
          "ssm:SendCommand",
          "ssm:DescribeInstanceInformation"
        ],
        "Resource" : "*",
        "Condition" : {
          "BoolIfExists" : {
            "ssm:SessionDocumentAccessCheck" : "false"
          }
        }
      }
    ]
  })
}

#===========================================================================
#Criando Role
#===========================================================================
resource "aws_iam_role" "PermiteSSMGenrenciarEC2" {
  name = var.nome_role_iam

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Effect : "Allow",
        Principal : {
          Service : "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Anexa a política customizada (AcessoDeAdministradorFleetManager)à role
resource "aws_iam_role_policy_attachment" "anexa_politica_ssm_ec2" {
  role       = aws_iam_role.PermiteSSMGenrenciarEC2.name
  policy_arn = aws_iam_policy.politica_ssm_ec2.arn
}

# Anexa a política gerenciada `AmazonSSMManagedInstanceCore` à role
resource "aws_iam_role_policy_attachment" "anexa_politica_aws" {
  role       = aws_iam_role.PermiteSSMGenrenciarEC2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#===========================================================================
#Anexando Função criada ao Perfil EC2
#===========================================================================
resource "aws_iam_instance_profile" "perfil_ec2" {
  name = var.nome_instance_profile
  role = aws_iam_role.PermiteSSMGenrenciarEC2.name
}