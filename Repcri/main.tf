terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13"  # Sostituisci con la versione corretta del provider
    }
  }
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx_container" {
  image = docker_image.nginx.latest
  name  = "nginx-server"
  ports {
    internal = 80
    external = 8080
  }

  volumes {
    host_path      = "${abspath(path.module)}/index"
    container_path = "/usr/share/nginx/html"
  }

  volumes {
    host_path      = "${abspath(path.module)}/nginx/nginx.conf"
    container_path = "/etc/nginx/conf.d/default.conf"
  }
}
