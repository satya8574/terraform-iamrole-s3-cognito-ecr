resource "aws_iam_role" "veloce_role" {
  name = var.role_name #"test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    role_nname    = var.role_name     #"veloce_role"
    role_env      = var.role_env      # "  Dev"
    role_build_by = var.role_build_by #"terraform"
  }
}
#This is going to create IAM role but we can’t link this role to AWS instance and for that, we need EC2 instance Profile
#Step2

#Create EC2 Instance Profile
resource "aws_iam_instance_profile" "test_profile" { #add to instance 
  name = var.instance_role_profile_name              #"test_profile"
  role = aws_iam_role.veloce_role.name
}

resource "aws_iam_role_policy" "test_policy" {
  name = var.ploicy_name #test_policy"
  role = aws_iam_role.veloce_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"

      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
            "Effect": "Allow",
            "Action": [
                "ecr:*",
                "cloudtrail:LookupEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "replication.ecr.amazonaws.com"
                    ]
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "cognito-identity:Describe*",
                "cognito-identity:Get*",
                "cognito-identity:List*",
                "cognito-idp:Describe*",
                "cognito-idp:AdminGet*",
                "cognito-idp:AdminList*",
                "cognito-idp:List*",
                "cognito-idp:Get*",
                "cognito-sync:Describe*",
                "cognito-sync:Get*",
                "cognito-sync:List*",
                "iam:ListOpenIdConnectProviders",
                "iam:ListRoles",
                "sns:ListPlatformApplications"
            ],
            "Resource": "*"
        }




  ]
}


EOF

}
#Step4

#Attach this role to EC2 instance
resource "aws_instance" "role-test" {
  ami                  = var.ec2_ami
  subnet_id            = data.aws_subnet.public-subnet.id
  instance_type        = var.instance_type 
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  key_name             = var.key_name
  tags  = {
    "Name"     = "Ubuntu_Server"
    "Env"      = "Dev"
    "Build_by" = "Terraform_cloud"
    "Project"  = "Veloce"
  }
}
