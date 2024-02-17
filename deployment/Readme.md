# AWS Configuration with Terraform

## Introduction

This repository contains Terraform code for configuring AWS infrastructure based on the specifications provided in the `services.yml` file. The configuration defines the resources to be provisioned in the AWS environment, facilitating the setup of various components such as VPC, EC2 instances, security groups, and more.

## Workflow Overview

1. **Reading Configuration**: The `main.tf` file reads the `services.yml` configuration file, which specifies all the services needed for deployment. These configurations are provided under the `services/` directory, where each service has its own set of AWS infrastructure settings defined in separate files. This YAML file provides a human-readable format for defining the infrastructure requirements.

2. **Middleware Processing**: The Terraform script processes the configuration data and sends it to a middleware component. This middleware interprets the configuration and determines the types of resources to be created based on the specifications provided.

3. **Resource Provisioning**: The middleware forwards the resource specifications to the respective Terraform modules responsible for creating specific AWS resources. For instance, VPC-related configurations are handled by the VPC module, which further decomposes the requirements into smaller components such as Elastic IP, Subnets, Security Groups, Internet Gateway, and Route Tables with given association.

4. **EC2 Instance Configuration**: Upon provisioning the necessary infrastructure components, the EC2 module receives the resource IDs generated during the creation process. It uses these IDs to position the EC2 instances within the designated environment. Additionally, the EC2 module generates and downloads the required PEM file for SSH access to the instances.

5. **User Data Execution**: The EC2 module executes the provided script located in the `scripts` directory. This script installs and runs the application within the EC2 instances, ensuring that the environment is fully configured and operational upon instance initialization. The user data section of the EC2 instance definition specifies the script to be executed during instance bootstrapping.

## Getting Started

To use this Terraform configuration:

1. Clone the repository to your local machine.
2. Ensure that Terraform is installed on your system.
3. Configure your AWS credentials by using the `aws configure` command.
4. Update the `services.yml` file with your desired AWS infrastructure configuration.
5. Execute `terraform init` to initialize the Terraform environment.
6. Run `terraform plan` to review the proposed infrastructure changes.
7. Execute `terraform apply` to provision the AWS resources based on the defined configuration.
8. Monitor the Terraform output for any errors or warnings during the provisioning process.
9. Once the provisioning is complete, verify that the infrastructure is configured as expected in the AWS Management Console.
10. After provisioning, you will see an IP in the output of terraform, hit that ip along with `/health` path to access the application.

## Additional Notes

- EC2 might take a bit to come up after the terraform code executes successfuly. Give it sometime, it will work in a moment.




Feel free to reach out for assistance or clarification regarding the Terraform configuration and AWS infrastructure setup. Happy provisioning!
