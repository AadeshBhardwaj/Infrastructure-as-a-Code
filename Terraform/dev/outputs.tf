#ALB Outputs
output "load_balancer_arn" {
  description = "The ARN of the load balancer we created."
  value       = module.alb.lb_arn
}
output "load_balancer_id" {
  description = "The ID of the load balancer we created."
  value       = module.alb.lb_id
}
output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.alb.lb_dns_name
}
output "target_group_arns" {
  description = "ARNs of the target groups. Useful for passing to your Auto Scaling group."
  value       = module.alb.target_group_arns
}
output "target_group_names" {
  description = "Name of the target group. Useful for passing to your CodeDeploy Deployment Group."
  value       = module.alb.target_group_names
}


# VPC outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

#ASG Outputs
output "launch_template_id" {
  description = "The ID of the launch configuration"
  value       = module.asg.launch_template_id
}

output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.asg.autoscaling_group_id
}


#EC2 Outputs
output "pritunl_public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = module.pritunl.public_ip
}