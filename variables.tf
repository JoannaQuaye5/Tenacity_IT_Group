variable "region" {
 type = string
 description = "aws region" 
  default = "eu_west_2"
}

variable "vpc_cidr" {
 type = string
 description = "cidr block for vpc" 
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
 type = string
 description = "cidr block for public subnet1" 
  default = "10.0.1.0/28"
}

variable "public_subnet_2_cidr" {
 type = string
 description = "cidr block for public subnet2" 
  default = "10.0.2.0/28"
  }

variable "private_subnet_1_cidr" {
 type = string
 description = "cidr block for private subnet1" 
  default = "10.0.3.0/28"
  }

variable "private_subnet_2_cidr" {
 type = string
 description = "cidr block for private subnet2" 
  default = "10.0.4.0/28"
  }