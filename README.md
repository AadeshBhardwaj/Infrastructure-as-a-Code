# Infrastructure-as-a-Code

This repository contains code for provisioning the AWS Infrastructure and creating the NodeJs Application AMI

#Getting started
To get the infrastructure running on AWS:
- Clone this repository
- Change directory to Terraform/dev/
- Run "terraform init" to install all the required modules from the given source
- Run "terraform plan -out=dev" to save the plan in a file named "dev"(you may chnage the name as per choice)
- Run "terraform apply dev" to see the resources to be created, after typing "yes" in console, your AWS Infrastructure will be provisioned


#To build AMI for NodeJS Application(BACKEND):
- Change directory into Packer/
- Run "packer init NodeJS AMI.json" for initializing packer, although it won't get initialized for a JSON File....STILL WE DO IT...FORMALITY!
- Run "packer validate NodeJS AMI.json" for validating the configuration of this file
- Run "packer build NodeJS AMI.json" to start creating the AMI and observe the process to know how it happens. Trust me, it's completely, MAGICAL!

#Code Overview
##Dependencies
- terraform - To provision AWS Infrastructure
- packer - To provision the NodeJS Application AMI
- aws cli v2 - To configure AWS Credentials(Access Key ID, Secret Access Key and Region) of the account in which we are deploying the Web Application

##Application Structure
- Terraform/ - This folder contains terraform code to create infrastructure for 3-Tier WebApp Deployment in AWS.
- Packer/ - This folder contains the code to create AMI for the backend i.e NodeJS Application.

##Authentication:
Install "AWS cli" and configure AWS Credentials(Access Key ID, Secret Access Key and Region) of the account in which we are deploying the Web Application.
NOTE: You may also export Access Key ID and Secret Access Key to .env file and map the variables in provider.tf
