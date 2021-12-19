output "private_ip" {
  value = aws_instance.corda_instance.private_ip
}

output "bastion_dns" {
  value = aws_instance.bastion_instance.public_dns
}

output "developer" {
  value = var.developer
}

output "alb" {
  value = aws_lb.corda_alb.dns_name
}

resource "local_file" "ssh_config" {
  filename        = "config_${var.developer}"
  content         = "Host bastion\n    Hostname ${aws_instance.bastion_instance.public_dns}\n    User centos\n    IdentityFile ${path.cwd}/${aws_instance.corda_instance.key_name}.pem\n\nHost ${aws_instance.corda_instance.private_ip}\n    ProxyJump bastion\n    User centos\n    IdentityFile ${path.cwd}/${aws_instance.corda_instance.key_name}.pem"
  file_permission = "0755"
}

output "tls_private_key" {
  value = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}
