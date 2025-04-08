# outputs.tf
output "web_server_ip" {
  description = "The public IP of the web server"
  value       = ibm_is_instance.web_server.public_ip
}

output "web_server_name" {
  description = "The name of the web server instance"
  value       = ibm_is_instance.web_server.name
}

