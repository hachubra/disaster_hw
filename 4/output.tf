output internal_ip_address_vm {
  value = yandex_compute_instance.vm.*.network_interface.0.ip_address
}
output external_ip_address_vm {
  value = yandex_compute_instance.vm.*.network_interface.0.nat_ip_address
}
output "lb_ip" {
    value = yandex_lb_network_load_balancer.lb-1.listener
}