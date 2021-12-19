resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.developer
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "ssh_private_key" {
  filename        = "${var.developer}.pem"
  content         = tls_private_key.ssh_key.private_key_pem
  file_permission = "0400"
}
