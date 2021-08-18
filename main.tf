terraform {
  required_providers {
    docker = {
      source  = "terraform-providers/docker"
      version = "~> 2.7.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  length = 4
  special = false
  upper = false 
}

resource "docker_container" "nodered_container" {
  name  = "nodered"
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    # external = 1880
  }
}

resource "docker_container" "nodered_container_2" {
  name  = "nodered2"
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    # external = 1880
  }
}

# output "IP-Address" {
#     value = join(":", [docker_container.nodered_container.ip_address, docker_container.nodered_container.ports[0].external])
#     description = "The IP addess of the container."
# }

# output "IP-Address" {
#     value = join(":", [docker_container.nodered_container.ip_address, docker_container.nodered_container.ports[0].external])
#     description = "The IP addess of the container."
# }

output "container-name" {
    value = docker_container.nodered_container.name
    description = "The name of the container"
}