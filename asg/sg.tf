########### Security Group creation for Launch Template ##################
resource "aws_security_group" "web-asg-vm-sg" {

  name        = "asg_web_vm_sg"
  description = "Web Server Security Group"
  //vpc_id      = aws_vpc.fosfor_vpc.id
  vpc_id      = var.vpc_id
  tags = {
    Name = "web-asg-vm-sg"
  }
}
############ Security Group inbound rule creation for test-asg-vm-sg ####
resource "aws_security_group_rule" "ssh-web-ingress" {
  //  count             = var.enabled ? length(var.security_groups) : 0
  type              = "ingress"
  from_port         = "22" //SSH Port
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web-asg-vm-sg.id
  }

resource "aws_security_group_rule" "web-ingress" {
  //  count             = var.enabled ? length(var.security_groups) : 0
  type              = "ingress"
  from_port         = "80" //SSH Port
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web-asg-vm-sg.id
  }
###### Security Group outbound rule creation for test-asg-vm-sg #######
resource "aws_security_group_rule" "web-egress" {
  //  count             = var.enabled ? 1 : 0
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web-asg-vm-sg.id
  }

  ##############################

  ########## Security Group creation for Launch Template ##################
resource "aws_security_group" "app-asg-vm-sg" {

  name        = "asg_app_vm_sg"
  description = "App Server Security Group"
  //vpc_id      = aws_vpc.fosfor_vpc.id
  vpc_id      = var.vpc_id
  tags = {
    Name = "app-asg-vm-sg"
  }
}
############ Security Group inbound rule creation for test-asg-vm-sg ####
resource "aws_security_group_rule" "ssh-app-ingress" {
  //  count             = var.enabled ? length(var.security_groups) : 0
  type              = "ingress"
  from_port         = "22" //SSH Port
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = ["${var.vpc_cidr}"]
  security_group_id = aws_security_group.app-asg-vm-sg.id
  }

resource "aws_security_group_rule" "app-egress" {
  //  count             = var.enabled ? 1 : 0
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app-asg-vm-sg.id
  }
