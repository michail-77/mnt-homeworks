/* data "yandex_compute_image" "centos_image" {
  family = "centos-7"
}
 
resource "yandex_compute_instance" "vm-clickhouse" {
  name = "clickhouse"
 
  resources {
    cores  = 2
    memory = 2
  }
 
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos_image.id
    }
  }
  */

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }
 
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
 
}
 
resource "yandex_vpc_network" "network_terraform" {
  name = "net_terraform"
}
 
resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "sub_terraform"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.15.0/24"]
}
