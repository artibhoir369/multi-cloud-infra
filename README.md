# 🌐 Multi-Cloud DevOps Infrastructure with Terraform, Ansible & CI/CD

This project demonstrates a complete DevOps setup that provisions and manages infrastructure across **AWS** and **IBM Cloud** using **Terraform**, configures instances with **Ansible**, deploys a Dockerized application via a **CI/CD pipeline (GitHub Actions)**, and provides centralized **monitoring/logging**.

---

## 📦 Tech Stack

- **Infrastructure as Code**: Terraform (modularized)
- **Configuration Management**: Ansible
- **CI/CD Pipeline**: GitHub Actions
- **Cloud Providers**: AWS & IBM Cloud
- **Monitoring & Logging**: Prometheus + Grafana 
- **Containerization**: Docker

---

## 🚀 How to Set Up and Run the Infrastructure

### 🔧 Prerequisites
- Add your AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, EC2_SSH_PRIVATE_KEY  under github settings > secrets > actions
- start consule and ngrok, (in case you are using s3 backend for terraform then this step not required) 
```bash
consul agent -dev
ngrok http 8500
```

- Update following line in .github/workflows/ci-cd.yml AND infra/aws/backend.tf # Replace with your public URL
```bash
CONSUL_HTTP_ADDR: "https://41d3-45-115-184-224.ngrok-free.app"  # Replace with your public URL in .github/workflows/ci-cd.yml
```
- Update following line in infra/aws/backend.tf # Replace with your public URL
```bash
address = "https://41d3-45-115-184-224.ngrok-free.app"  # Correct HTTP API URL  in infra/aws/backend.tf
```
- AWS CLI & IBM Cloud CLI configured with credentials
- Docker (for building the app)
- SSH key pair for access

### 🏗️ Step-by-Step Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-user/your-repo.git
   cd your-repo
   ```

2. **Provision Infrastructure**

   - Push to `main` branch
   - GitHub Actions will create infra, build and deploy

---

## 🔁 Deployment Pipeline Architecture

### 📂 GitHub Actions Workflow

- **Trigger**: On push to `main`
- **Steps**:
  1. Run `terraform apply` for AWS 
  2. Build Docker image
  4. Run Ansible to configure and deploy the app

### 🧱 Directory Structure
```
.github/
infra/
├── aws/
├── ibm/
ansible/
monitoring/
```

---
## Monitoring setup
cd monitoring
update public IP of ec2 in prometheus.yml
update index.js to scrap logs, rebuild image and container on ec2
docker build -t sample-node-app:latest /opt/webapp
docker run -d --name node-webapp --restart always -p 3000:3000 sample-node-app:latest

then
docker-compose up -d (on your laptop # should have docker desktop running)

## 📊 Accessing merics and Monitoring Dashboard

### 🌍 Grafana Dashboard
- URL: `http://<monitoring-instance-ip>:3000`
- Default Credentials: `admin/admin`
- Dashboards:
  - System metrics (CPU, memory, disk)
  - Docker/container status
  - App health endpoints

### 📚 metrics (Prometheus)
- - URL: `http://<monitoring-instance-ip>:9090`
- Prometheus is integrated to pull logs from Docker containers.
- Access via Grafana → Explore tab → Log query

---

## 💡 Assumptions & Design Decisions

- The app is containerized using Docker for consistency across environments.
- Terraform modules are used to ensure reusable infrastructure definitions.
- Ansible roles abstract out server configuration logic.
- Monitoring/logging is done via open-source tools to avoid vendor lock-in.

---

## 💰 Cost Implications

- **AWS**:
  - EC2 used with free-tier or spot instances (recommended).
  - Costs may incur for data transfer, EBS storage, CloudWatch (if used).

- **IBM Cloud**:
  - Lite plans used where possible (e.g., VSI).
  - Some resource limits may apply under free tiers.

### Cost Optimization Techniques
- Spot instances on AWS
- Use of lightweight compute types (e.g., t3.micro, bx2-2x8)
- Minimal persistent storage
- Autoscaling not enabled by default, but modular support is included

---

## 🔐 Security Considerations

- SSH access is restricted via security groups/firewalls (specific IPs only)
- All cloud credentials are kept out of version control
- Encrypted storage volumes are enabled where supported
- Docker images should be scanned and signed for production
- Secrets should be injected via environment variables or secret managers

---
