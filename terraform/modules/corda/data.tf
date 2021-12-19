data "aws_ami" "base_instance_ami" {
  most_recent      = true

  filter {
    name   = "name"
    values = ["Corda_Base *"]
  }

  owners     = ["self"]
}

data "aws_ami" "corda_base_ami" {
  most_recent      = true

  filter {
    name   = "name"
    values = ["Corda *"]
  }

  owners     = ["self"]
}