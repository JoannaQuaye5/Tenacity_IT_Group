output "vpc_id"  {
  value = aws_vpc.Holy-vpc.id
}

output "vpc_cidr_block" {
  value = "0.0.0.0/16"
}

output "public_subnet1_cidr_block" {
  value = "0.0.1.0/28"
}

output "public_subnet2_cidr_block" {
  value = "0.0.2.0/28"
}

output "private_subnet1_cidr_block" {
  value = "0.0.3.0/28"
}

output "private_subnet2_cidr_block" {
  value = "0.0.4.0/28"
}
