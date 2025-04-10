terraform {
  backend "consul" {
    address = "https://41d3-45-115-184-224.ngrok-free.app"  # Correct HTTP API URL
    path    = "terraform/state"  # Path to store the state in Consul
  }
}

