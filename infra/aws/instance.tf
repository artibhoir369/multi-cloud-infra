resource "aws_instance" "web_server" {
  ami                         = var.aws_ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.default.id
  vpc_security_group_ids      = [aws_security_group.aws-linux-sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "Web Server"
  }


  # User data for instance initialization
  user_data = <<-EOF
              #!/bin/bash
              # Set the root password
              echo "root:test123" | chpasswd

              # Modify SSH configuration for root login and password authentication
              sed -i '/^PermitRootLogin/d' /etc/ssh/sshd_config
              sed -i '/^PasswordAuthentication/d' /etc/ssh/sshd_config
              sed -i '/^PasswordAuthentication/d' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
              sed -i '/^#PermitRootLogin/d' /etc/ssh/sshd_config
              sed -i '/^#PasswordAuthentication/d' /etc/ssh/sshd_config

              # Add PermitRootLogin yes and PasswordAuthentication yes
              echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
              echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

              # Restart SSH service to apply changes
              systemctl restart ssh
              EOF
}

