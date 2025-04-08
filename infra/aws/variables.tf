variable "aws_region" {
  description = "The AWS region to launch resources in"
  type        = string
  default     = "us-east-2"
}

variable "aws_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c3b809fcf2445b6a"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "SSH key pair name for EC2 instance"
  type        = string
  default     = "onelab"

}

