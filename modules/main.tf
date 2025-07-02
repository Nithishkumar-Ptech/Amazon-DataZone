
/*provider "aws" {
  region  = var.aws_region
  
}

resource "aws_datazone_domain" "healthcare" {
  name                  = "healthcare"
  domain_execution_role = aws_iam_role.domain_execution_role.arn
}

resource "aws_security_group" "newsg1" {
  name = "newsg1"
}



resource "aws_datazone_project" "healthcare" {
  domain_identifier = aws_datazone_domain.healthcare.id
  name              = "healthcare-project"
  description       = "Healthcare DataZone project"
}


data "aws_caller_identity" "healthcare" {}
data "aws_region" "us-east-1" {}

data "aws_datazone_environment_blueprint" "test" {
  domain_id = aws_datazone_domain.healthcare.id
  name      = "DefaultDataLake"
  managed   = true
}

resource "aws_datazone_environment_blueprint_configuration" "healthcare" {
  domain_id                = aws_datazone_domain.healthcare.id
  environment_blueprint_id = data.aws_datazone_environment_blueprint.test.id
  provisioning_role_arn    = aws_iam_role.domain_execution_role.arn
  enabled_regions          = [data.aws_region.us-east-1.id]
}

resource "aws_datazone_environment_profile" "health" {
  aws_account_id                   = data.aws_caller_identity.healthcare.account_id
  aws_account_region               = data.aws_region.us-east-1.id
  description                      = "description"
  environment_blueprint_identifier = data.aws_datazone_environment_blueprint.test.id
  name                             = "health"
  project_identifier               = aws_datazone_project.healthcare.id
  domain_identifier                = aws_datazone_domain.healthcare.id
  user_parameters {
    name  = "consumerGlueDbName"
    value = "value"
  }
}

resource "aws_iam_role" "domain_execution_role" {
  name = "datazone-execution-role-2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "datazone.amazonaws.com"
        },
        Action = "sts:AssumeRole"
        
      }
    ]
  })
}
resource "aws_iam_role_policy" "datazone_permissions" {
  name = "DataZoneBasicPermissions"
  role = aws_iam_role.domain_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "datazone:GetEnvironmentProfile",
          "datazone:ListEnvironmentProfiles",
          "datazone:GetDomain",
          "datazone:ListDomains",
          "datazone:GetProject",
          "datazone:ListProjects",
          "datazone:GetEnvironment",
          "datazone:ListEnvironments"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "domain_exec_policy" {
  name = "DataZoneExecutionPolicy"
  role = aws_iam_role.domain_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "datazone:*",
          "s3:*",
          "kms:*"
        ],
        Resource = "*"
      }
    ]
  })
}*/

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "aws_region" "selected" {}
data "aws_caller_identity" "healthcare" {}

resource "aws_iam_role" "domain_execution_role" {
  name = var.execution_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "datazone.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "datazone_permissions" {
  name = "DataZoneBasicPermissions"
  role = aws_iam_role.domain_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "datazone:GetEnvironmentProfile",
        "datazone:ListEnvironmentProfiles",
        "datazone:GetDomain",
        "datazone:ListDomains",
        "datazone:GetProject",
        "datazone:ListProjects",
        "datazone:GetEnvironment",
        "datazone:ListEnvironments"
      ],
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy" "domain_exec_policy" {
  name = "DataZoneExecutionPolicy"
  role = aws_iam_role.domain_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "datazone:*",
        "s3:*",
        "kms:*"
      ],
      Resource = "*"
    }]
  })
}

resource "aws_security_group" "newsg1" {
  name = var.sg_name
}

resource "aws_datazone_domain" "healthcare" {
  name                  = var.domain_name
  domain_execution_role = aws_iam_role.domain_execution_role.arn
}

resource "aws_datazone_project" "healthcare" {
  domain_identifier = aws_datazone_domain.healthcare.id
  name              = var.project_name
  description       = var.project_description
}

data "aws_datazone_environment_blueprint" "test" {
  domain_id = aws_datazone_domain.healthcare.id
  name      = var.environment_blueprint_name
  managed   = true
}

resource "aws_datazone_environment_blueprint_configuration" "healthcare" {
  domain_id                = aws_datazone_domain.healthcare.id
  environment_blueprint_id = data.aws_datazone_environment_blueprint.test.id
  provisioning_role_arn    = aws_iam_role.domain_execution_role.arn
  enabled_regions          = [data.aws_region.selected.id]
}

resource "aws_datazone_environment_profile" "health" {
  aws_account_id                   = data.aws_caller_identity.healthcare.account_id
  aws_account_region               = data.aws_region.selected.id
  description                      = var.environment_description
  environment_blueprint_identifier = data.aws_datazone_environment_blueprint.test.id
  name                             = var.environment_profile_name
  project_identifier               = aws_datazone_project.healthcare.id
  domain_identifier                = aws_datazone_domain.healthcare.id

  user_parameters {
    name  = var.environment_param_name
    value = var.environment_param_value
  }
}


