resource "aws_vpc" "Holy-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "Holy-vpc"
  }
}

#public subnet1
resource "aws_subnet" "Prod-public-subnet1" {
  vpc_id     = aws_vpc.Holy-vpc.id
  cidr_block = var.public_subnet1_cidr
  tags = {
    Name = "Prod-public-subnet1"
  }  
}

#public subnet2
resource "aws_subnet" "Prod-public-subnet2" {
  vpc_id     = aws_vpc.Holy-vpc.id
  cidr_block = var.public_subnet2_cidr
  tags = {
    Name = "Prod-public-subnet2"
  }  
}

#private subnet1
resource "aws_subnet" "Prod-private-subnet1" {
  vpc_id     = aws_vpc.Holy-vpc.id
  cidr_block = var.private_subnet1_cidr
  tags = {
    Name = "Prod-private-subnet1"
  }  
}

#private subnet2
resource "aws_subnet" "Prod-private-subnet2" {
  vpc_id     = aws_vpc.Holy-vpc.id
  cidr_block = var.private_subnet2_cidr
  tags = {
    Name = "Prod-private-subnet2"
  }  
}

#aws public route table
resource "aws_route_table" "Prod-public-route-table" {
   vpc_id = aws_vpc.Holy-vpc.id
   tags = {
     Name = "Prod-public-route-table"
   }
}

#aws private route table
resource "aws_route_table" "Prod-private-route-table" {
   vpc_id = aws_vpc.Holy-vpc.id
   tags = {
     Name = "Prod-private-route-table"
   } 
}

#aws public route table association with public subnet 1
resource "aws_route_table_association" "Prod-public-route-table-association" {
  subnet_id = aws_subnet.Prod-public-subnet1.id
  route_table_id = aws_route_table.Prod-public-route-table.id
}

#aws public route table association with public subnet 1
resource "aws_route_table_association" "Prod-public-route-table-association1" {
  subnet_id = aws_subnet.Prod-public-subnet1.id
  route_table_id = aws_route_table.Prod-public-route-table.id
  }

#aws private route table association with private subnet 1
resource "aws_route_table_association" "Prod-private-route-table-association" {
  subnet_id = aws_subnet.Prod-private-subnet1.id
  route_table_id = aws_route_table.Prod-private-route-table.id
}

#aws private route table association with private subnet 1
resource "aws_route_table_association" "Prod-private-route-table-association1" {
  subnet_id = aws_subnet.Prod-private-subnet1.id
  route_table_id = aws_route_table.Prod-private-route-table.id
}

#aws igw
resource "aws_internet_gateway" "Prod-igw" {
    vpc_id = aws_vpc.Holy-vpc.id
    
    tags = {
      Name = "Prod-igw"
    } 
}
#aws route for igw & public route table
resource "aws_route" "public-internet-igw-route" {
  route_table_id = aws_route_table.Prod-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.Prod-igw.id
}
#aws nat gateway
resource "aws_eip" "Jo-IP" {
    tags = {
      Name = "Jo-IP"
    } 
}
#create NAT Gateway
resource "aws_nat_gateway" "Prod-nat-gateway" {
allocation_id = aws_eip.Jo-IP.id
subnet_id = aws_subnet.Prod-public-subnet1.id
}
# NAT Associate with Priv route
resource "aws_route" "private-route" {
route_table_id = aws_route_table.Prod-private-route-table.id
gateway_id     = aws_nat_gateway.Prod-nat-gateway.id
destination_cidr_block = "0.0.0.0/0"
}


