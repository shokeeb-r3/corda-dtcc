
resource "aws_instance" "bastion_instance" {
  ami                    = data.aws_ami.base_instance_ami.id
  instance_type          = var.bastion_instance_type
  subnet_id              = aws_subnet.corda_public_subnet.id
  vpc_security_group_ids = aws_security_group.bastion_sg.*.id
  iam_instance_profile = aws_iam_instance_profile.corda_iam_profile.id
  key_name = aws_key_pair.generated_key.key_name
  associate_public_ip_address = "true"
  depends_on = [
    aws_internet_gateway.corda_igw
  ]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
  }

  lifecycle {
    ignore_changes = [ebs_block_device]
  }

  tags = {
    Name = "${var.developer} Bastion Instance"
    Owner = var.developer
  }

}

resource "aws_instance" "corda_instance" {
  ami                    = data.aws_ami.corda_base_ami.id
  instance_type          = var.corda_instance_type
  subnet_id              = aws_subnet.corda_private_subnet.id
  vpc_security_group_ids = aws_security_group.corda_sg.*.id
  iam_instance_profile = aws_iam_instance_profile.corda_iam_profile.id
  key_name = aws_key_pair.generated_key.key_name
  user_data = var.instance_user_data
  depends_on = [aws_nat_gateway.corda_nat_gateway]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 25
  }

  lifecycle {
    ignore_changes = [ebs_block_device]
  }

  tags = {
    Name = "${var.developer} Corda Instance"
    Owner = "${var.developer}"
  }
}
