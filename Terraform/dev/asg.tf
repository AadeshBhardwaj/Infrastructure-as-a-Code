locals {
  image                = "ami-0f9f5736c98ffd004"
  lt_name              = "Aadesh-MERN-LT"
  iam_instance_profile = "aadesh-CodeDeploy-CloudWatch"
}

#ASG and LT
module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name                      = "Aadesh-NodeJS"
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = [element(module.vpc.private_subnets, 0), element(module.vpc.private_subnets, 1)]
  target_group_arns         = module.alb.target_group_arns


  # Launch template
  launch_template_name        = local.lt_name
  launch_template_description = "Launch template for NodeJS"
  update_default_version      = true
  image_id                    = local.image
  instance_type               = local.instance_type
  iam_instance_profile_name   = local.iam_instance_profile
  ebs_optimized               = true
  enable_monitoring           = true
  key_name                    = local.key_name
  network_interfaces = [
    {
      delete_on_termination = true
      device_index          = 0
      security_groups       = [aws_security_group.node.id]
    }
  ]
  tags = {
    Name  = "Aadesh-NodeJS-ASG"
    Owner = local.owner
  }
}

# Scaling Policy
resource "aws_autoscaling_policy" "asg-policy" {
  
  name                      = "Aadesh-asg-cpu-policy"
  autoscaling_group_name    = module.asg.autoscaling_group_name
  estimated_instance_warmup = 60
  policy_type               = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}

#Backend Security Group
resource "aws_security_group" "node" {
  name   = "ApplicationServer-SG"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.pritunl-sg.id]
  }

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "TCP"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Aadesh-NodeJS-ApplicationServer-SG"
    Owner = local.owner
  }
}