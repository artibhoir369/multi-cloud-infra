output "prometheus_ip" {
  value = aws_instance.prometheus.public_ip
}

output "grafana_ip" {
  value = aws_instance.grafana.public_ip
}

