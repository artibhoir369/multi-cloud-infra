output "instance_id" {
  value = aws_instance.web_server.id
}

output "security_group_id" {
  value = aws_security_group.aws-linux-sg.id
}

