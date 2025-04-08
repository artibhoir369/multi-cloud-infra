# network.tf
resource "ibm_is_vpc" "main" {
  name = "my-vpc"
}

resource "ibm_is_security_group" "sg" {
  name        = "web_sg"
  description = "Allow HTTP and SSH"
}

