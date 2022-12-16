locals {
  instance_type        = "t3a.small"
  instance_ami         = "ami-0530ca8899fac469f"
  key_name             = "aadesh"
  lt_name              = "Aadesh-MERN-LT"
  image                = "ami-0b44a4c4b894f12f4"
  iam_instance_profile = "aadesh-CodeDeploy-CloudWatch"
  vpc_name             = "Aadesh-VPC"
}

##################
# Mongo Instances
##################

module "ec2_multiple" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["1", "2", "3"])
  name     = "aadesh-mongo-${each.key}"

  instance_type          = local.instance_type
  ami                    = local.instance_ami
  subnet_id              = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids = [aws_security_group.mongo.id]
  key_name               = local.key_name
  monitoring             = true

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10
    }
  ]

  tags = {
    Owner = "Aadesh"
  }
  user_data = file("mongo_download_script.sh")

}

#######################
# Mongo Security Group
#######################

resource "aws_security_group" "mongo" {
  name   = "Mongo-DB-SG"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.pritunl-sg.id]
  }
  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "TCP"
    security_groups = [aws_security_group.node.id]
  }
  ingress {
    from_port = 27017
    to_port   = 27017
    protocol  = "TCP"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Aadesh-Mongo-DB-SG"
    Owner = "Aadesh"
  }
}