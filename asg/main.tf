
/* This will Launch template for auto-sacling */

resource "aws_launch_template" "web-lnch-temp" {
  name_prefix   = "web-lnch-temp"
  image_id = var.launch_template_ami
  instance_type = var.instance_type
  
  user_data = <<EOF
   IyEvYmluL2Jhc2gKeXVtIHVwZGF0ZSAteQphbWF6b24tbGludXgtZXh0cmFzIGluc3RhbGwgLXkKeXVtIGluc3RhbGwgLXkgaHR0cGQueDg2XzY0CnN5c3RlbWN0bCBzdGFydCBodHRwZC5zZXJ2aWNlCnN5c3RlbWN0bCBlbmFibGUgaHR0cGQuc2VydmljZQplY2hvIOKAnEhlbGxvIFdvcmxkIGZyb20gJChob3N0bmFtZSAtZinigJ0gPiAvdmFyL3d3dy9odG1sL2luZGV4Lmh0bWw=
   EOF
   tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "web-asg-vm"
    }
  }
  key_name 		= var.key_name
  vpc_security_group_ids      = [aws_security_group.web-asg-vm-sg.id]
}


/* This will create auto-sacling group */

resource "aws_autoscaling_group" "web-asg" {
  name               = "web-asg"
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  health_check_grace_period = 300
  // health_check_type         = "ELB"
  force_delete              = true
  vpc_zone_identifier       = [var.publicsubnet01_id, var.publicsubnet02_id]
  launch_template {
    id      = aws_launch_template.web-lnch-temp.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "web_scaling" {
  name                   = "simple_scaling_policy"
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.average_cpu_util_web
  }
  autoscaling_group_name = aws_autoscaling_group.web-asg.name
}

resource "aws_launch_template" "app-lnch-temp" {
  name_prefix   = "app-lnch-temp"
  image_id = var.launch_template_ami
  instance_type = var.instance_type
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "app-asg-vm"
    }
  }
  key_name 		= var.key_name
  vpc_security_group_ids      = [aws_security_group.app-asg-vm-sg.id]
}


/* This will create auto-sacling group */

resource "aws_autoscaling_group" "app-asg" {
  name               = "app-asg"
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  health_check_grace_period = 300
  // health_check_type         = "ELB"
  force_delete              = true
  vpc_zone_identifier       = [var.privatesubnet01_id, var.privatesubnet02_id]
  launch_template {
    id      = aws_launch_template.app-lnch-temp.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "app_scaling" {
  name                   = "simple_scaling_policy"
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.average_cpu_util_app
  }
  autoscaling_group_name = aws_autoscaling_group.app-asg.name
}

resource "aws_autoscaling_attachment" "asg_attachment_web" {
  autoscaling_group_name = aws_autoscaling_group.web-asg.id
  lb_target_group_arn = var.web-alb_arn
}

