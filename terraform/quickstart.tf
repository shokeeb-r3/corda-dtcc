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

  # uncomment one of these two lines and add your ip address/addresses
  # whitelist = ["151.230.0.17/32", "18.133.200.210/32"]
   whitelist = ["74.73.32.245/32"]

  corda_vpc_cidr = "${var.quickstart_cidr_prefix}.0.0/16"
  corda_pub_subnet_cidr = "${var.quickstart_cidr_prefix}.1.0/24"
  corda_prv_subnet_cidr = "${var.quickstart_cidr_prefix}.2.0/24"
  corda_nlb_subnet_cidr = "${var.quickstart_cidr_prefix}.3.0/24"
  instance_user_data = "${file("userdata.sh")}"
  azs_list = "${var.quickstart_aws_region}a"
  
 
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
  value = "${module.quickstart_corda_instance.nlb}:3000"
}

output "quickstart_kibana_endpoint" {
  value = "${module.quickstart_corda_instance.nlb}:5601"
}

