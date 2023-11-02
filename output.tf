output "vpc_id"  {
  value = aws_vpc.Holy-vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.Holy-vpc.cidr_block
}

output "public_subnet1_cidr" {
  value = aws_subnet.Prod-public-subnet1.cidr_block
}

output "private_subnet1_cidr" {
  value = aws_subnet.Prod-private-subnet1.cidr_block
}

output "public_subnet_id" {
  value = aws_subnet.Prod-public-subnet1.id
}

output "private_subnet_id" {
  value = aws_subnet.Prod-private-subnet1.id
}



