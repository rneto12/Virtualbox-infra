
resource "virtualbox_vm" "node" {
  count = 1
  name = "node"
  image = "Ubuntu-20.04.box"
  cpus = 2
  memory = "2 Gib"

  network_adapter {
    type = "nat"
    device = "IntelPro1000MTDesktop"
    host_interface = "NatNetwork"
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
