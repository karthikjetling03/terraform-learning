provider "aws" {
  region = var.aws_region
}

# configure s3 backend 
terraform {
  backend "s3" {
    bucket = "terraform-learning-karthik"
    key    = "terraform/terraform.tfstate"
    region = "ap-south-1"
  }
}

# configure VPC
resource "aws_vpc" "vpc-terra" {

  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_tag_name
  }
}

# configure public subnet

resource "aws_subnet" "public-subnet-terra" {
  vpc_id                  = aws_vpc.vpc-terra.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.subnet_az
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_tag_name
  }
}

# configure internet gateway
resource "aws_internet_gateway" "igw-terra" {
  vpc_id = aws_vpc.vpc-terra.id

  tags = {
    Name = var.igw_tag_name
  }
}

# configure route table
resource "aws_route_table" "rt-terra" {
  vpc_id = aws_vpc.vpc-terra.id
  tags = {
    Name = var.rt_tag_name
  }

}

# configure route
resource "aws_route" "route-terra" {
  route_table_id         = aws_route_table.rt-terra.id
  destination_cidr_block = var.internet_cidr_block
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
  name        = var.sg_name
  description = "this security group has been created via terraform"

}

# create ingress rule to allow all traffic for ssh
resource "aws_vpc_security_group_ingress_rule" "sg-ssh-ingress-terra" {
  security_group_id = aws_security_group.sg-terra.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"

}

# create ingress rule to allow all traffic for https
resource "aws_vpc_security_group_ingress_rule" "sg-https-ingress-terra" {
  security_group_id = aws_security_group.sg-terra.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}

# create egress rule to allow all traffic
resource "aws_vpc_security_group_egress_rule" "sg-all-egress-terra" {
  security_group_id = aws_security_group.sg-terra.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

}

# create EC2 instance
resource "aws_instance" "linux-terra" {
  ami                         = "ami-02ddb77f8f93ca4ca"
  subnet_id                   = aws_subnet.public-subnet-terra.id
  key_name                    = var.ec2_key_name
  instance_type               = var.ec2_instance_type
  vpc_security_group_ids      = [aws_security_group.sg-terra.id]
  associate_public_ip_address = true
  tags = {
    Name = var.ec2_tag_name
  }
  depends_on = [aws_vpc.vpc-terra] # exlicit dependency

}