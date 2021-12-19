variable "quickstart_aws_region" {
  default = "us-west-2"
}

variable "quickstart_cidr_prefix" {
  default = 10.1  
}

module "quickstart_corda_instance" {
  source = "./modules/corda"

  developer = "quickstart"
  bastion_instance_type = "t2.micro"
  corda_instance_type = "t3a.xlarge"


  corda_vpc_cidr = "${var.quickstart_cidr_prefix}.0.0/16"
  corda_pub_subnet_cidr = "${var.quickstart_cidr_prefix}.1.0/24"
  corda_prv_subnet_cidr = "${var.quickstart_cidr_prefix}.2.0/24"
  corda_alb_subnet_cidr = ["${var.quickstart_cidr_prefix}.3.0/24", "${var.quickstart_cidr_prefix}.4.0/24", "${var.quickstart_cidr_prefix}.5.0/24"]
  instance_user_data = "${file("userdata.sh")}"
  azs_list = ["${var.quickstart_aws_region}a", "${var.quickstart_aws_region}b", "${var.quickstart_aws_region}c"]
  instance_az = "${var.quickstart_aws_region}a"

 
}


output "quickstart_corda_private_ip" {
  value = module.quickstart_corda_instance.private_ip
}

output "quickstart_bastion_dns" {
  value = module.quickstart_corda_instance.bastion_dns
}

output "quickstart_ssh_to_corda_instance" {
  value = "ssh -i ${module.quickstart_corda_instance.developer} -F config_${module.quickstart_corda_instance.developer} ${module.quickstart_corda_instance.private_ip}"
}

output "quickstart_grafana_endpoint" {
  value = "${module.quickstart_corda_instance.alb}:3000"
}

output "quickstart_kibana_endpoint" {
  value = "${module.quickstart_corda_instance.alb}:5601"
}

