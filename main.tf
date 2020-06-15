#################################
# airflow
#################################

provider "aws" {
  region = var.aws_region
}


# Data sources to get VPC details
//data "aws_vpc" "default" {
//  default = true
//}


variable "fernet_key" {
  description = ""
  type        = string
  default     = "HeY9Aivs7vADx5oy7SBKHfRJdj3fhpD_6IX2LnlDN74"
}

//module "airflow_cluster" {
//  source            = "./terraform-aws-airflow"
//  cluster_name      = "airflow-example-deploy"# Put in variable
//  s3_bucket_name    = "airflow-example-deploy-logs"# Put in variable
//  db_password       = "123456789A*"# Put in variable                                   # Just for example purposes, for real projects you may want to create a terraform.tfvars file
////  fernet_key        = "HeY9Aivs7vADx5oy7SBKHfRJdj3fhpD_6IX2LnlDN74=" # Just for example purposes, for real projects you may want to create a terraform.tfvars file
//  fernet_key = var.fernet_key
//  key_name          = module.aws_key_pair.key_name
//  load_example_dags = false
//
//  vpc_id = module.aws_vpc.vpc_id
//}


#################################
# EMR
#################################

module "s3_log_storage" {
  source        = "git::https://github.com/cloudposse/terraform-aws-s3-log-storage.git?ref=tags/0.5.0"
  region        = var.aws_region
  namespace     = var.namespace
  stage         = var.stage
  name          = var.name
  attributes    = ["logs"]
  force_destroy = true
}

module "emr_cluster" {
  source    = "github.com/cloudposse/terraform-aws-emr-cluster"
  namespace = var.namespace
  stage     = var.stage
  name      = var.name

  //  master_allowed_security_groups                 = [module.vpc.vpc_default_security_group_id]
  //  slave_allowed_security_groups                  = [module.vpc.vpc_default_security_group_id]

  region = var.aws_region

  vpc_id = module.aws_vpc.vpc_id
  //  subnet_id                                      = module.subnets.private_subnet_ids[0]
  subnet_id = module.aws_vpc.public_subnets[0]

  //  route_table_id                                 = module.subnets.private_route_table_ids[0]
  route_table_id = module.aws_vpc.public_route_table_ids[0]
  subnet_type    = var.subnet_type

  ebs_root_volume_size                           = var.ebs_root_volume_size
  visible_to_all_users                           = var.visible_to_all_users
  release_label                                  = var.release_label
  applications                                   = var.applications
  configurations_json                            = var.configurations_json
  core_instance_group_instance_type              = var.core_instance_group_instance_type
  core_instance_group_instance_count             = var.core_instance_group_instance_count
  core_instance_group_ebs_size                   = var.core_instance_group_ebs_size
  core_instance_group_ebs_type                   = var.core_instance_group_ebs_type
  core_instance_group_ebs_volumes_per_instance   = var.core_instance_group_ebs_volumes_per_instance
  master_instance_group_instance_type            = var.master_instance_group_instance_type
  master_instance_group_instance_count           = var.master_instance_group_instance_count
  master_instance_group_ebs_size                 = var.master_instance_group_ebs_size
  master_instance_group_ebs_type                 = var.master_instance_group_ebs_type
  master_instance_group_ebs_volumes_per_instance = var.master_instance_group_ebs_volumes_per_instance
  create_task_instance_group                     = var.create_task_instance_group

  log_uri  = format("s3://%s", module.s3_log_storage.bucket_id)
  key_name = module.aws_key_pair.key_name
}
