resource "docker_image" "mariadb" {
  name = "mariadb:5.5"
}

resource "docker_container" "mysql" {
  name = "wordpress-mysql"
  image = "${docker_image.mariadb.latest}"
  env = [
    "MYSQL_ROOT_PASSWORD=secpass"
  ]
}

resource "docker_image" "wordpress" {
  name = "wordpress:latest"
}

resource "docker_container" "wordpress" {
  name = "wordpress"
  image = "${docker_image.wordpress.latest}"
  env = [
    "WORDPRESS_DB_HOST=${docker_container.mysql.ip_address}",
    "WORDPRESS_DB_PASSWORD=secpass"
  ]
}

