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
  count = 2
  length = 4
  special = false
  upper = false 
}

# resource "random_string" "random2" {
#   length = 4
#   special = false
#   upper = false
# }

resource "docker_container" "nodered_container" {
  count = 2
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    # external = 1880
  }
}

# resource "docker_container" "nodered_container_2" {
#   name  = join("-", ["nodered2", random_string.random2.result])
#   image = docker_image.nodered_image.latest
#   ports {
#     internal = 1880
#     # external = 1880
#   }
# }

output "IP-Address" {
    value = join(":", [docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].ports[0].external])
    description = "The IP addess of the container."
}

output "IP-Address-2" {
    value = join(":", [docker_container.nodered_container[1].ip_address, docker_container.nodered_container[1].ports[0].external])
    description = "The IP addess of the container."
}

output "container-name" {
    value = docker_container.nodered_container[0].name
    description = "The name of the container"
}

output "container-name-2" {
    value = docker_container.nodered_container[1].name
    description = "Then name of the container 2"
}