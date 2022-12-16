#ASG and LT
module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"
  # Autoscaling group
  name                      = "Aadesh-NodeJS"
  min_size                  = 1
  max_size                  = 1
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
  security_groups             = [aws_security_group.node.id]
  tags = {
    Name  = "Aadesh-NodeJS-ASG"
    Owner = "Aadesh"
  }
}
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
    Owner = "Aadesh"
  }
}