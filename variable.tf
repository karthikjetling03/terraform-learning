variable "aws_region" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "subnet_cidr_block" {
  type = string
}

variable "subnet_az" {
  type = string
}

variable "internet_cidr_block" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "ec2_key_name" {
  type = string
}

variable "vpc_tag_name" {

}

variable "subnet_tag_name" {

}

variable "igw_tag_name" {

}

variable "rt_tag_name" {

}

variable "sg_name" {

}

variable "ec2_tag_name" {

}