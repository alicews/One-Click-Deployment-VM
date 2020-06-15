resource "aws_security_group" "airflow" {
  name   = "airflow"
  vpc_id = module.vpc.vpc_id

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "airflow_ssh" {
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.airflow.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "airflow_http" {
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = aws_security_group.airflow.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

variable "airflow_instance_type" {
  default = "t3.medium"
}

variable "airflow_root_volume_size" {
  default = 8
}

//resource "aws_instance" "airflow" {
//  ami           = data.aws_ami.ubuntu_1804.id
//  instance_type = var.airflow_instance_type
//
//  subnet_id = module.aws_vpc.public_subnets[0]
//  //  subnet_id              = module.subnets.private_subnet_ids[0]
//  vpc_security_group_ids = [aws_security_group.airflow.id]
//
//  key_name               = module.aws_key_pair.key_name
//
//  root_block_device {
//    volume_size = var.airflow_root_volume_size
//  }
//}

module "airflow" {
  source    = "github.com/insight-infrastructure/terraform-aws-ec2-airflow"
  subnet_id = module.aws_vpc.public_subnets[0]

  vpc_security_group_ids = [aws_security_group.airflow.id]

  public_key_path  = var.ssh_public_key_path
  private_key_path = var.private_key_path

  root_volume_size = var.airflow_root_volume_size
}
