variable "name_prefix" {
  description = "Name prefix for EC2 instance(s)"
}

variable "count" {
  default     = "1"
  description = "Number of EC2 instance(s) to be provisioned"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Type of EC2 instance"
}

variable "ami" {
  description = "AMI used to provision"
}

variable "network_configuration" {
  type        = "map"
  description = "Network configuration (subnet_ids) used when provisioning EC2 instance(s)"
}

variable "security_configuration" {
  type        = "map"
  description = "Security configuration (security_group_ids, iam_instance_profile) used when provisioning EC2 instance(s)"
}

variable "tags" {
  type        = "map"
  description = "Addtional tags for EC2 instance(s)"
  default     = {}
}
