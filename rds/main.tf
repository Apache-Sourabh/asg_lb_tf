resource "aws_db_instance" "rds" {
  allocated_storage    = var.allocated_storage
  db_name              = "${var.db_name}"
  engine               = "${var.db_engine}"
  engine_version       = "${var.db_engine_version}"
  instance_class       = "${var.db_instance_class}"
  username             = "${var.db_user}"
  password             = "${var.db_password}"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.rds_sub_grp.name
}