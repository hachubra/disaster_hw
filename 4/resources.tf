resource "yandex_compute_instance" "vm" {
  count = 2
  name = "vm${count.index}"
  platform_id = "standard-v1"
  hostname = "vm${count.index}"
  
  resources {
    cores  = 2
    memory = 2
    core_fraction = 5
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd87kbts7j40q5b9rpjr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta.txt")}"
  }

}
resource "yandex_vpc_network" "network-1" {
  name = "network-1"
}


resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet-1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_lb_target_group" "disaster-hw4" {
    name = "disaster-hw4"    

    dynamic "target" {
      for_each = [for s in yandex_compute_instance.vm : {
        address = s.network_interface.0.ip_address
        subnet_id = s.network_interface.0.subnet_id
      }]

      content {
        subnet_id = target.value.subnet_id
        address   = target.value.address
      }
    }
  }

  resource "yandex_lb_network_load_balancer" "lb-1" {
    name = "lb-1"
    deletion_protection = "false"
    listener {
        name = "my-lb1"
        port = 80
        external_address_spec {
            ip_version = "ipv4"
        }
    }
    attached_target_group {
      target_group_id = yandex_lb_target_group.disaster-hw4.id
      healthcheck {
        name = "http" 
        http_options{
          port = 80
          path = "/"
        }
      }
    }
  }