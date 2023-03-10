################# VPC #################

module "vpc_v1" {
  source = "../vpc"

  vpc_cidr = var.vpc_cidr
  infra_env = var.infra_env
  public-subnet-1-cidr_block = var.public-subnet-1-cidr_block
  public-subnet-1-az = var.public-subnet-1-az
  public-subnet-2-cidr_block = var.public-subnet-2-cidr_block
  public-subnet-2-az = var.public-subnet-2-az
  private-subnet-1-cidr_block = var.private-subnet-1-cidr_block
  private-subnet-1-az = var.private-subnet-1-az
  private-subnet-2-cidr_block = var.private-subnet-2-cidr_block
  private-subnet-2-az = var.private-subnet-2-az

}


################# Launch Template + Auto Scalling #################

module "lanuch-template" {
  source = "../asg"
  launch_template_ami       = var.launch_template_ami
  instance_type = var.instance_type
  key_name    = var.key_name
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  vpc_id = module.vpc_v1.vpc_id
  vpc_cidr                   = module.vpc_v1.vpc_cidr
  publicsubnet01_id = module.vpc_v1.public_subnet-1-id
  publicsubnet02_id = module.vpc_v1.public_subnet-2-id
  privatesubnet01_id = module.vpc_v1.private_subnet-1-id
  privatesubnet02_id = module.vpc_v1.private_subnet-2-id
  average_cpu_util_web = var.average_cpu_util_web
  average_cpu_util_app = var.average_cpu_util_app
  web-alb_arn = module.web_alb.web-alb_arn
}

################# Application Load Balancer #################

module "web_alb" {

  source = "../alb"

  vpc_id = module.vpc_v1.vpc_id
  infra_env = var.infra_env
  publicsubnet01_id = module.vpc_v1.public_subnet-1-id
  publicsubnet02_id = module.vpc_v1.public_subnet-2-id

}

module "rds" {

  source = "../rds"
  
  vpc_id = module.vpc_v1.vpc_id
  vpc_cidr = var.vpc_cidr
  privatesubnet01_id = module.vpc_v1.private_subnet-1-id
  privatesubnet02_id = module.vpc_v1.private_subnet-2-id
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  db_engine               = var.db_engine
  db_engine_version       = var.db_engine_version
  db_instance_class       = var.db_instance_class
  db_user             = var.db_user
  db_password             = var.db_password

}
