provider "aws" {
  region = var.aws_region
}
# Data source for the default VPC
data "aws_vpc" "default" {
  default = true
}

# Data source for the default subnet in the default VPC (with additional filter for availability zone)
data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id

  # Filter based on the availability zone to ensure only one subnet is selected
  availability_zone = "us-east-2a"  # Modify with your specific AZ or leave it to select a single subnet
}
