
resource "virtualbox_vm" "node" {
  count = 1
  name = "node"
  image = "Ubuntu-20.04.box"
  cpus = 2
  memory = "2 Gib"

  network_adapter {
    type = "bridged"
    host_interface = "enx8cae4ce10175"
    device = "IntelPro1000MTDesktop"
  }
}
output "IPAddr" {
  value = virtualbox_vm.node.*.network_adapter.0.ipv4_address
}

resource "local_file" "hosts_cfg" {
  content = templatefile("hosts.tmpl",
    {
      server = virtualbox_vm.node.*.network_adapter.0.ipv4_address
    }
  )
  filename = "../ansible/hosts"
}
