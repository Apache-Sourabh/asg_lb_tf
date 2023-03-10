resource "aws_db_subnet_group" "rds_sub_grp" {
  name       = "rds_sub_grp"
  subnet_ids = [var.privatesubnet01_id, var.privatesubnet02_id]

  tags = {
    Name = "RDS subnet group"
  }
}


resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Terraform RDS security group"
  vpc_id      = "${var.vpc_id}"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
