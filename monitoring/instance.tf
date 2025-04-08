# Prometheus EC2 instance
resource "aws_instance" "prometheus" {
  ami           = "ami-0c3b809fcf2445b6a"  # Ubuntu AMI for us-east-2 region (change as needed)
  instance_type = "t2.medium"
  security_groups = [aws_security_group.prometheus_grafana_sg.name]
  key_name      = "onlab"  # Specify your SSH key

  tags = {
    Name = "Prometheus"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update && sudo apt upgrade -y
              sudo apt install -y wget tar
              wget https://github.com/prometheus/prometheus/releases/download/v2.42.0/prometheus-2.42.0.linux-amd64.tar.gz
              tar -xvzf prometheus-2.42.0.linux-amd64.tar.gz
              cd prometheus-2.42.0.linux-amd64
              sudo mv prometheus promtool /usr/local/bin/
              sudo mkdir -p /etc/prometheus
              sudo mv prometheus.yml /etc/prometheus/prometheus.yml
              sudo prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/
              EOF
}

# Grafana EC2 instance
resource "aws_instance" "grafana" {
  ami           = "ami-0c3b809fcf2445b6a"  # Ubuntu AMI for us-east-2 region (change as needed)
  instance_type = "t2.medium"
  security_groups = [aws_security_group.prometheus_grafana_sg.name]
  key_name      = "onlab"  # Specify your SSH key

  tags = {
    Name = "Grafana"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update && sudo apt upgrade -y
              sudo apt install -y software-properties-common
              sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
              sudo apt update
              sudo apt install grafana -y
              sudo systemctl start grafana-server
              sudo systemctl enable grafana-server
              EOF
}

