# instances.tf
resource "ibm_is_instance" "web_server" {
  name              = "web-server"
  image_crn          = var.ibm_image_crn
  profile            = var.ibm_instance_type
  zone               = var.ibm_zone
  keys               = [var.ibm_ssh_key]
  vpc                = var.vpc_id
}

resource "ibm_is_security_group_rule" "ssh_rule" {
  security_group_id = ibm_is_security_group.sg.id
  direction         = "inbound"
  port_max          = 22
  port_min          = 22
  protocol          = "tcp"
  remote            = "0.0.0.0/0"
}

resource "ibm_is_security_group_rule" "http_rule" {
  security_group_id = ibm_is_security_group.sg.id
  direction         = "inbound"
  port_max          = 80
  port_min          = 80
  protocol          = "tcp"
  remote            = "0.0.0.0/0"
}

