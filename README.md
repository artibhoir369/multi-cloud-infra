```markdown
# 🌐 Multi-Cloud DevOps Infrastructure with Terraform, Ansible & CI/CD

This project demonstrates a complete DevOps setup that provisions and manages infrastructure across **AWS** and **IBM Cloud** using **Terraform**, configures instances with **Ansible**, deploys a Dockerized application via a **CI/CD pipeline (GitHub Actions)**, and provides centralized **monitoring/logging**.

---

## 📦 Tech Stack

- **Infrastructure as Code**: Terraform (modularized)
- **Configuration Management**: Ansible
- **CI/CD Pipeline**: GitHub Actions
- **Cloud Providers**: AWS & IBM Cloud
- **Monitoring & Logging**: Prometheus + Grafana + Loki
- **Containerization**: Docker

---

## 🚀 How to Set Up and Run the Infrastructure

### 🔧 Prerequisites
- Terraform (v1.5+)
- Ansible
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

   **AWS:**
   ```bash
   cd terraform/aws
   terraform init
   terraform apply -auto-approve
   ```

   **IBM Cloud:**
   ```bash
   cd ../ibm
   terraform init
   terraform apply -auto-approve
   ```

3. **Configure Instances**
   ```bash
   cd ../../ansible
   ansible-playbook -i inventory playbook.yml
   ```

4. **Deploy Application (Optional: from GitHub Actions)**
   - Push to `main` branch
   - GitHub Actions will build and deploy to both clouds

---

## 🔁 Deployment Pipeline Architecture

### 📂 GitHub Actions Workflow

- **Trigger**: On push to `main`
- **Steps**:
  1. Build Docker image
  2. Push image to container registry
  3. Run `terraform apply` for AWS and IBM in **parallel**
  4. Run Ansible to configure and deploy the app

### 🧱 Directory Structure
```
terraform/
├── aws/
├── ibm/
├── modules/
ansible/
ci-cd/
app/
monitoring/
```

---

## 📊 Accessing Logs and Monitoring

### 🌍 Grafana Dashboard
- URL: `http://<monitoring-instance-ip>:3000`
- Default Credentials: `admin/admin`
- Dashboards:
  - System metrics (CPU, memory, disk)
  - Docker/container status
  - App health endpoints

### 📚 Logs
- Loki is integrated to pull logs from Docker containers.
- Access via Grafana → Explore tab → Log query

---

## 💡 Assumptions & Design Decisions

- The app is containerized using Docker for consistency across environments.
- Terraform modules are used to ensure reusable infrastructure definitions.
- Ansible roles abstract out server configuration logic.
- Monitoring/logging is done via open-source tools to avoid vendor lock-in.
- Parallel deployments reduce time and mimic real-world multi-cloud delivery.

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
