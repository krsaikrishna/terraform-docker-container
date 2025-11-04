# main.tf

# Step 1: Define provider
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {
  # No configuration needed for local Docker
}

# Step 2: Pull Docker Image
resource "docker_image" "nginx_image" {
  name         = "nginx:latest"
  keep_locally = false
}

# Step 3: Create Docker Container
resource "docker_container" "nginx_container" {
  name  = "terraform-nginx"
  image = docker_image.nginx_image.latest
  ports {
    internal = 80
    external = 8080
  }
}
