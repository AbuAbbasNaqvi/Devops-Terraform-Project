terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0" # Use the latest compatible version
    }
  }
}

provider "docker" {}

resource "docker_image" "argocd_image" {
  name         = "argoproj/argocd:v2.8.0" # Replace with the desired version
  keep_locally = false
}

resource "docker_container" "argocd_container" {
  name  = "argocd"
  image = docker_image.argocd_image.latest
  ports {
    internal = 8080
    external = 8080
  }
}
