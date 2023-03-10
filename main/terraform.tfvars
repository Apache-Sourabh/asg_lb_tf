region = "us-east-1"
vpc_cidr = "10.0.0.0/16"
infra_env = "test-alb-asg"
public-subnet-1-cidr_block = "10.0.0.0/24"
public-subnet-1-az = "us-east-1a"
public-subnet-2-cidr_block = "10.0.1.0/24"
public-subnet-2-az = "us-east-1b"
private-subnet-1-cidr_block = "10.0.2.0/24"
private-subnet-1-az = "us-east-1a"
private-subnet-2-cidr_block = "10.0.3.0/24"
private-subnet-2-az = "us-east-1b"

################# Launch Template #################


launch_template_ami = "ami-026b57f3c383c2eec"
instance_type = "t2.micro"
key_name    = "adrnd"


################# Auto Scaling #################

desired_capacity   = "1"
max_size           = "3"
min_size           = "1"
average_cpu_util_web = 0.40
average_cpu_util_app = 0.40

################# RDS #################

db_name = "test_db"
db_engine = "mysql"
db_engine_version = "5.7"
db_instance_class = "db.t3.micro"
db_user = "db_admin"
db_password = "admin123"
allocated_storage = "10"
