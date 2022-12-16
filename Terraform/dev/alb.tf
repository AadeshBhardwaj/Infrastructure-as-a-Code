#ALB
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.2.1"

  name               = "aadesh-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = [element(module.vpc.public_subnets, 0), element(module.vpc.public_subnets, 1)]
  security_groups    = [aws_security_group.alb.id]
  target_groups = [
    {
      name             = "aadesh-TG"
      backend_protocol = "HTTP"
      backend_port     = 3000
      target_type      = "instance"
      # targets          = {}
      health_check = {
        enabled             = true
        interval            = 6
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "404"
      }
    }
  ]
  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:acm:us-west-2:421320058418:certificate/73b9c44b-3865-4f0a-b508-dc118857ae2e"
      target_group_index = 0
    }
  ]
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
  tags = {
    Owner = "Aadesh"
  }
}

resource "aws_security_group" "alb" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Aadesh-ALB-SG"
    Owner = "Aadesh"
  }
}