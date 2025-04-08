# variables.tf
variable "ibm_region" {
  description = "IBM Cloud region"
  type        = string
}

variable "ibm_image_crn" {
  description = "The CRN of the IBM Cloud image"
  type        = string
}

variable "ibm_instance_type" {
  description = "The type of instance to be created"
  type        = string
}

variable "ibm_zone" {
  description = "The zone where the instance will be provisioned"
  type        = string
}

variable "ibm_ssh_key" {
  description = "The SSH key for accessing the instance"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

