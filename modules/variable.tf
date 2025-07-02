/*variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}*/


variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = "default"
}

variable "domain_name" {
  default = "healthcare"
}

variable "project_name" {
  default = "healthcare-project"
}

variable "project_description" {
  default = "Healthcare DataZone project"
}

variable "environment_blueprint_name" {
  default = "DefaultDataLake"
}

variable "environment_description" {
  default = "Healthcare DataZone environment profile"
}

variable "environment_profile_name" {
  default = "health"
}

variable "environment_param_name" {
  default = "consumerGlueDbName"
}

variable "environment_param_value" {
  default = "value"
}

variable "execution_role_name" {
  default = "datazone-execution-role-2"
}

variable "sg_name" {
  default = "newsg1"
}
