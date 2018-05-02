resource "aws_instance" "resource_name" {
ami = "${var.aws_ami}"
instance_type = "${var.aws_instance_type}"
}
