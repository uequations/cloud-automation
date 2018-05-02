variable "aws_ami" {
description = "The AMI to use for the instance"
default = "ami-6871a115" #Red Hat Enterprise Linux 7.5 (HVM), SSD Volume Type
}

variable "aws_instance_type" {
description = "The type of instance to start"
default = "t2.micro" #Free tier eligible
}

variable "aws_region" {
description = "The AWS region"
default = "us-east-1"
}
