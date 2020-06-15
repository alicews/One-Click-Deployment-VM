//#################################
//# Superset
//#################################
//
//variable "superset_instance_type" {
//  description = "Size of instance for superset"
//  type = string
//  default = "t3.medium"
//}
//
//data "aws_ami" "ubuntu_1804" {
//  most_recent = true
//  owners      = ["099720109477"] # Canonical
//
//  filter {
//    name   = "name"
//    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
//  }
//
//  filter {
//    name   = "virtualization-type"
//    values = ["hvm"]
//  }
//}
//
//resource "aws_security_group" "superset" {
//  name = "superset"
//  vpc_id = module.vpc.vpc_id
//
//  egress {
//    from_port = 0
//    to_port   = 0
//    protocol  = "-1"
//    cidr_blocks = [
//      "0.0.0.0/0"]
//  }
//}
//
//resource "aws_security_group_rule" "superset_ssh" {
//  from_port = 22
//  to_port = 22
//  protocol = "tcp"
//  security_group_id = aws_security_group.superset.id
//  type = "ingress"
//  cidr_blocks = ["0.0.0.0/0"]
//}
//
//resource "aws_security_group_rule" "superset_http" {
//  from_port = 8080
//  to_port = 8080
//  protocol = "tcp"
//  security_group_id = aws_security_group.superset.id
//  type = "ingress"
//  cidr_blocks = ["0.0.0.0/0"]
//}
//
//resource "aws_instance" "superset" {
//  ami           = data.aws_ami.ubuntu_1804.id
//  instance_type = var.superset_instance_type
//
//  subnet_id = module.aws_vpc.public_subnets[0]
//  //  subnet_id              = module.subnets.private_subnet_ids[0]
//    vpc_security_group_ids = [aws_security_group.superset.id]
//
//  key_name               = module.aws_key_pair.key_name
//
//  root_block_device {
//    volume_size = var.superset_root_volume_size
//  }
//}
//
//resource "aws_eip" "superset" {}
//
//resource "aws_eip_association" "superset" {
//  instance_id = aws_instance.superset.id
//  public_ip   = aws_eip.superset.public_ip
//}
//
//module "superset_ansible" {
//  source           = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git?ref=v0.8.0"
//  ip               = aws_eip_association.superset.public_ip
//  user             = "ubuntu"
//  private_key_path = var.private_key_path
//
//  playbook_file_path = "${path.module}/ansible-superset-playbook/install_superset.yml"
//  playbook_vars = {}
//}
