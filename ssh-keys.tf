resource "local_file" "ssh_key" {
  count = 3
  filename = "${var.prefix}-ssh-key-${count.index}"
  content  = tls_private_key.ssh[count.index].private_key_pem
}

resource "null_resource" "display_ssh_key" {
  count = 3
  triggers = {
    ssh_key = local_file.ssh_key[count.index].content
  }
  provisioner "local-exec" {
    command = "echo 'SSH Key ${count.index}:'"
    on_failure = "continue"
  }
  provisioner "local-exec" {
    command = "echo ${local_file.ssh_key[count.index].content}"
    on_failure = "continue"
  }
}
