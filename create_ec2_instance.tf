provider "aws" {
  region = "ap-south-1"
}

# configure VPC
resource "aws_vpc" "vpc-terra" {

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-terraform"
  }
}

# configure public subnet

resource "aws_subnet" "public-subnet-terra" {
  vpc_id                  = aws_vpc.vpc-terra.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-terraform"
  }
}

# configure internet gateway
resource "aws_internet_gateway" "igw-terra" {
  vpc_id = aws_vpc.vpc-terra.id

  tags = {
    Name = "igw-terraform"
  }
}

# configure route table
resource "aws_route_table" "rt-terra" {
  vpc_id = aws_vpc.vpc-terra.id
  tags = {
    Name = "route-table-terraform"
  }

}

# configure route
resource "aws_route" "route-terra" {
  route_table_id         = aws_route_table.rt-terra.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw-terra.id
}

# configure subnet association
resource "aws_route_table_association" "rta-terra" {
  subnet_id      = aws_subnet.public-subnet-terra.id
  route_table_id = aws_route_table.rt-terra.id

}

# create security groups
resource "aws_security_group" "sg-terra" {
  vpc_id      = aws_vpc.vpc-terra.id
  name        = "SG-Terraform"
  description = "this security group has been created via terraform"

}

resource "aws_vpc_security_group_ingress_rule" "sg-ssh-ingress-terra" {
  security_group_id = aws_security_group.sg-terra.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"

}

resource "aws_vpc_security_group_ingress_rule" "sg-https-ingress-terra" {
  security_group_id = aws_security_group.sg-terra.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "sg-all-egress-terra" {
  security_group_id = aws_security_group.sg-terra.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

}

# create EC2 instance
resource "aws_instance" "linux-terra" {
  ami                         = "ami-02ddb77f8f93ca4ca"
  subnet_id                   = aws_subnet.public-subnet-terra.id
  key_name                    = "linux"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.sg-terra.id]
  associate_public_ip_address = true
  tags = {
    Name = "Linux-RH9"
  }
}