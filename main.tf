#VPC
resource "aws_vpc" "Holy_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "Holy_vpc"
  }
}

#public subnet1
resource "aws_subnet" "Prod_public_subnet_1" {
  vpc_id     = aws_vpc.Holy_vpc.id
  cidr_block = var.public_subnet_1_cidr
  tags = {
    Name = "Prod_public_subnet_1"
  }  
}

#public subnet2
resource "aws_subnet" "Prod_public_subnet_2" {
  vpc_id     = aws_vpc.Holy_vpc.id
  cidr_block = var.public_subnet_2_cidr
  tags = {
    Name = "Prod_public_subnet_2"
  }  
}

#private subnet1
resource "aws_subnet" "Prod_private_subnet_1" {
  vpc_id     = aws_vpc.Holy_vpc.id
  cidr_block = var.private_subnet_1_cidr
  tags = {
    Name = "Prod_private_subnet_1"
  }  
}

#private subnet2
resource "aws_subnet" "Prod_private_subnet_2" {
  vpc_id     = aws_vpc.Holy_vpc.id
  cidr_block = var.private_subnet_2_cidr
  tags = {
    Name = "Prod_private_subnet_2"
  }  
}

#aws public route table
resource "aws_route_table" "Prod_public_route_table" {
   vpc_id = aws_vpc.Holy_vpc.id
   tags = {
     Name = "Prod_public_route_table"
   }
}

#aws private route table
resource "aws_route_table" "Prod_private_route_table" {
   vpc_id = aws_vpc.Holy_vpc.id
   tags = {
     Name = "Prod_private_route_table"
   } 
}

#aws public route table association with public subnet 1
resource "aws_route_table_association" "Prod_public_route_table_association" {
  subnet_id = aws_subnet.Prod_public_subnet_1.id
  route_table_id = aws_route_table.Prod_public_route_table.id
}

#aws public route table association with public subnet 2
resource "aws_route_table_association" "Prod_public_route_table_association1" {
  subnet_id = aws_subnet.Prod_public_subnet_1.id
  route_table_id = aws_route_table.Prod_public_route_table.id
  }

#aws private route table association with private subnet 1
resource "aws_route_table_association" "Prod_private_route_table_association" {
  subnet_id = aws_subnet.Prod_private_subnet_1.id
  route_table_id = aws_route_table.Prod_private_route_table.id
}

#aws private route table association with private subnet 2
resource "aws_route_table_association" "Prod_private_route_table_association1" {
  subnet_id = aws_subnet.Prod_private_subnet_1.id
  route_table_id = aws_route_table.Prod_private_route_table.id
}

#aws igw
resource "aws_internet_gateway" "Prod_igw" {
    vpc_id = aws_vpc.Holy_vpc.id
    
    tags = {
      Name = "Prod_igw"
    } 
}
#aws route for igw & public route table
resource "aws_route" "public_internet_igw_route" {
  route_table_id = aws_route_table.Prod_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.Prod_igw.id
}
#aws nat gateway
resource "aws_eip" "Jo_IP" {
    tags = {
      Name = "Jo_IP"
    } 
}
#create NAT Gateway
resource "aws_nat_gateway" "Prod_nat_gateway" {
allocation_id = aws_eip.Jo_IP.id
subnet_id = aws_subnet.Prod_public_subnet_1.id
}
# NAT Associate with Priv route
resource "aws_route" "private_route" {
route_table_id = aws_route_table.Prod_private_route_table.id
gateway_id     = aws_nat_gateway.Prod_nat_gateway.id
destination_cidr_block = "0.0.0.0/0"
}


