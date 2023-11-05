output "vpc_id"  {
  value = aws_vpc.Holy_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.Holy_vpc.cidr_block
}

output "public_subnet1_cidr" {
  value = aws_subnet.Prod_public_subnet_1.cidr_block
}

output "private_subnet1_cidr" {
  value = aws_subnet.Prod_private_subnet_1.cidr_block
}

output "public_subnet_id" {
  value = aws_subnet.Prod_public_subnet_1.id
}

output "private_subnet_id" {
  value = aws_subnet.Prod_private_subnet_1.id
}



