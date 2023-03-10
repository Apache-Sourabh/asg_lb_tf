variable "vpc_id" {
  type        = string
  description = "VPC ID"
}
variable "vpc_cidr" {
  #	type = list(string)
  type        = string
  description = "CIDR for the specified VPC"
  //  default     = "192.168.0.0/16"
}


variable "publicsubnet01_id" {
}


variable "publicsubnet02_id" {
}

variable "privatesubnet01_id" {
}

variable "privatesubnet02_id" {
}


############Input for launch template ########

variable "launch_template_ami" {
}

variable "instance_type" {
}


variable "key_name" {
}



############Input for Auto Scaling Group ########

variable "desired_capacity" {
}

variable "max_size" {
}


variable "min_size" {
}

variable "average_cpu_util_web" {
}

variable "average_cpu_util_app" {
}

variable "web-alb_arn" {
}
