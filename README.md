# Reference Architecture for Recommendation Engine

Terraform code to deploy a recommendation engine with Apache Airflow cluster to schedule Spark jobs.

![](architecture.png)

## Reference Module

1. [terraform-aws-airflow](https://github.com/PowerDataHub/terraform-aws-airflow)

2. [terraform-aws-emr-cluster](https://github.com/cloudposse/terraform-aws-emr-cluster)

## Usage
```
terraform init

terraform apply -var-file="example.tfvars"

```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| airflow\_instance\_type | n/a | `string` | `"t3.medium"` | no |
| airflow\_root\_volume\_size | n/a | `number` | `8` | no |
| applications | A list of applications for the cluster. Valid values are: Flink, Ganglia, Hadoop, HBase, HCatalog, Hive, Hue, JupyterHub, Livy, Mahout, MXNet, Oozie, Phoenix, Pig, Presto, Spark, Sqoop, TensorFlow, Tez, Zeppelin, and ZooKeeper (as of EMR 5.25.0). Case insensitive | `list(string)` | n/a | yes |
| availability\_zones | List of availability zones | `list(string)` | n/a | yes |
| aws\_region | AWS region | `string` | `"us-west-2"` | no |
| configurations\_json | A JSON string for supplying list of configurations for the EMR cluster | `string` | `""` | no |
| core\_instance\_group\_ebs\_size | Core instances volume size, in gibibytes (GiB) | `number` | n/a | yes |
| core\_instance\_group\_ebs\_type | Core instances volume type. Valid options are `gp2`, `io1`, `standard` and `st1` | `string` | n/a | yes |
| core\_instance\_group\_ebs\_volumes\_per\_instance | The number of EBS volumes with this configuration to attach to each EC2 instance in the Core instance group | `number` | n/a | yes |
| core\_instance\_group\_instance\_count | Target number of instances for the Core instance group. Must be at least 1 | `number` | n/a | yes |
| core\_instance\_group\_instance\_type | EC2 instance type for all instances in the Core instance group | `string` | n/a | yes |
| create\_task\_instance\_group | Whether to create an instance group for Task nodes. For more info: https://www.terraform.io/docs/providers/aws/r/emr_instance_group.html, https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-master-core-task-nodes.html | `bool` | n/a | yes |
| ebs\_root\_volume\_size | Size in GiB of the EBS root device volume of the Linux AMI that is used for each EC2 instance. Available in Amazon EMR version 4.x and later | `number` | n/a | yes |
| fernet\_key | n/a | `string` | `"HeY9Aivs7vADx5oy7SBKHfRJdj3fhpD_6IX2LnlDN74"` | no |
| generate\_ssh\_key | If set to `true`, new SSH key pair will be created | `bool` | n/a | yes |
| master\_instance\_group\_ebs\_size | Master instances volume size, in gibibytes (GiB) | `number` | n/a | yes |
| master\_instance\_group\_ebs\_type | Master instances volume type. Valid options are `gp2`, `io1`, `standard` and `st1` | `string` | n/a | yes |
| master\_instance\_group\_ebs\_volumes\_per\_instance | The number of EBS volumes with this configuration to attach to each EC2 instance in the Master instance group | `number` | n/a | yes |
| master\_instance\_group\_instance\_count | Target number of instances for the Master instance group. Must be at least 1 | `number` | n/a | yes |
| master\_instance\_group\_instance\_type | EC2 instance type for all instances in the Master instance group | `string` | n/a | yes |
| name | Name  (e.g. `app` or `cluster`) | `string` | n/a | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | `string` | n/a | yes |
| private\_key\_path | The path to private key. | `string` | n/a | yes |
| release\_label | The release label for the Amazon EMR release. https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-release-5x.html | `string` | n/a | yes |
| ssh\_public\_key\_path | Path to SSH public key directory (e.g. `/secrets`) | `string` | n/a | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`, `infra`) | `string` | n/a | yes |
| subnet\_type | public or porivate subnet | `string` | `"public"` | no |
| superset\_root\_volume\_size | n/a | `number` | `8` | no |
| visible\_to\_all\_users | Whether the job flow is visible to all IAM users of the AWS account associated with the job flow | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_key\_pair\_key\_name | Name of SSH key |
| aws\_key\_pair\_private\_key\_filename | Private Key Filename |
| aws\_key\_pair\_public\_key | Content of the generated public key |
| aws\_key\_pair\_public\_key\_filename | Public Key Filename |
| cluster\_id | EMR cluster ID |
| cluster\_master\_host | Name of the cluster CNAME record for the master nodes in the parent DNS zone |
| cluster\_master\_public\_dns | Master public DNS |
| cluster\_master\_security\_group\_id | Master security group ID |
| cluster\_name | EMR cluster name |
| cluster\_slave\_security\_group\_id | Slave security group ID |
| s3\_log\_storage\_bucket\_arn | Bucket ARN |
| s3\_log\_storage\_bucket\_domain\_name | FQDN of bucket |
| s3\_log\_storage\_bucket\_id | Bucket Name (aka ID) |
| vpc\_cidr | VPC ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Inputs

## Outputs
