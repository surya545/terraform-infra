# Dockerized Flask Application

This repository contains a Dockerized Flask application with a multi-stage Dockerfile for building and running the Flask application in a Python 3 Alpine-based environment.

## Dockerfile Explanation

The Dockerfile is organized into two stages: the builder stage and the production stage.

### Builder Stage (python:3-alpine as builder)

In this stage, the Python environment is set up to build the Flask application and install its dependencies.

- **Environment Setup**
- **Copying Files**
- **Dependencies Installation**

### Production Stage (python:3-alpine)

In this stage, the production image is created with a smaller footprint, focusing only on running the Flask application.

- **Environment Setup**
- **User and Permissions**
- **Exposing Ports**
- **Working Directory**
- **User Context**
- **Entry Point**


# Terraforming the Infrastructure (Ref: deployment/)

## Introduction

We need an EC2 to run the above Docker Container and access it which is quite simple.
When we Create EC2, AWS will create lot of things in background that we need to understand very well. So let's build everything from scratch.

This repository contains Terraform code to provision a fully functional infrastructure on AWS to host a Docker containerized application. The infrastructure includes a VPC with an Internet Gateway, a public subnet, security groups, an Elastic IP, a key pair for SSH access, and an EC2 instance running Docker.

## Infrastructure Components

The infrastructure consists of the following components:

1. **VPC (Virtual Private Cloud)**:
   - A virtual network environment in which the EC2 instance will be launched.
   - Associated with an Internet Gateway to allow internet access.

2. **Internet Gateway**:
   - Our VPC needs to be attached to an Internet Gateway to allow internet access.

3. **Subnet**:
   - A public subnet within the VPC to place the EC2 instance.

4. **Route Table**:
   - Routes internet-bound traffic from the subnet to the Internet Gateway.

5. **Security Groups**:
   - Inbound and outbound rules to control traffic to and from the EC2 instance.
   - Allows necessary ports for Docker, SSH, and other required services.

6. **Elastic IP**:
   - Provides a static public IP address for the EC2 instance.
   - Ensures consistent access to the instance even after restarts.

7. **Key Pair**:
   - Required for SSH access to the EC2 instance.
   - Allows debugging and maintenance tasks on the instance.

8. **EC2 Instance**:
   - Launches and hosts the Docker containerized application.
   - Configured with necessary security groups, and other parameters.

