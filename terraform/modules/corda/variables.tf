variable "corda_vpc_cidr" {

}

variable "corda_pub_subnet_cidr" {

}

variable "corda_prv_subnet_cidr" {
  
}

variable "corda_nlb_subnet_cidr" {
  
}

variable "developer" {

}

variable "bastion_instance_type" {
  
}


variable "instance_user_data" {
  default = ""
}


variable "corda_instance_type" {
  
}

variable "azs_list" {
  
}

variable aws_region {
  type        = string
  default     = "us-west-2"
  description = "aws region to create the resources"
}


variable "whitelist" {
  default = ["0.0.0.0/0"]
}