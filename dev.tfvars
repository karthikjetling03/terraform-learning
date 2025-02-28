aws_region          = "ap-south-1"
vpc_cidr_block      = "10.0.0.0/16"
subnet_cidr_block   = "10.0.1.0/24"
subnet_az           = "ap-south-1a"
internet_cidr_block = "0.0.0.0/0"
ec2_instance_type   = "t2.micro"
ec2_key_name        = "linux"
vpc_tag_name        = "vpc-terraform-dev"
subnet_tag_name     = "public-subnet-terraform-dev"
igw_tag_name        = "igw-terraform-dev"
rt_tag_name         = "route-table-terraform-dev"
sg_name             = "SG-Terraform-dev"
ec2_tag_name        = "Linux-RH9-dev"