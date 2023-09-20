terraform {
  required_version = "= 1.5.6"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.13"
    }
  }
}

/* provider "yandex" {
  token     = "AQAAAAAIkgGxAATuwW6RRMSneE2uuV6vpMTK0Jw"
  cloud_id  = "b1ghns2saijtpp8com7i"
  folder_id = "b1gb5mplcv6bu0g0eolj"
  zone      = "ru-central1-a"
}
 */


# **main.tf**:
#```hcl
provider "yandex" {
  token     = "AQAAAAAIkgGxAATuwW6RRMSneE2uuV6vpMTK0Jw"
  cloud_id  = "b1ghns2saijtpp8com7i"
  folder_id = "b1gb5mplcv6bu0g0eolj"
  zone      = "ru-central1-a"
}

/* resource "yandex_vpc_network" "network" {
  name = "terraform-network"
  subnet {
    name = "subnet-1"
    zone = "ru-central1-a"
    v4_cidr_blocks = ["192.168.15.0/24"]
  }
} */

resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "sub_terraform"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.15.0/24"]
}

resource "yandex_compute_instance" "vm" {
  count          = 3
  name           = "centos7-vm-${count.index}"
  zone           = "ru-central1-a"
  platform_id    = "standard-v1"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "centos-7-latest"
      size     = 10
    }
  }
/*   network_interface {
    subnet_id = yandex_vpc_network.network.subnet[0].id
    nat       = true
  } */
  metadata {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}
