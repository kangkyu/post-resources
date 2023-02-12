terraform {
  cloud {
    organization = "lining-link"

    workspaces {
      name = "post-resources"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = "~> 1.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}

# virtual private cloud
resource "aws_vpc" "rds" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  # enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "rds"
  }
}

resource "aws_security_group" "mysg" {
  name = "mysg"

  description = "RDS postgres servers (terraform-managed)"
  vpc_id      = aws_vpc.rds.id
  depends_on  = [
    aws_vpc.rds
  ]

  # Only postgres in
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.rds.id

  tags = {
    Name = "igw"
  }
}

resource "aws_subnet" "rds_a" {
  vpc_id            = aws_vpc.rds.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "rds_b" {
  vpc_id            = aws_vpc.rds.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "rds_c" {
  vpc_id            = aws_vpc.rds.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2c"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "rds_a_private" {
  vpc_id            = aws_vpc.rds.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "rds_b_private" {
  vpc_id            = aws_vpc.rds.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "rds_c_private" {
  vpc_id            = aws_vpc.rds.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-west-2c"
  map_public_ip_on_launch = false
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [
    aws_subnet.rds_a.id,
    aws_subnet.rds_b.id,
    aws_subnet.rds_c.id,
    aws_subnet.rds_a_private.id,
    aws_subnet.rds_b_private.id,
    aws_subnet.rds_c_private.id
  ]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_parameter_group" "example" {
  name   = "mypg"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_password" "password" {
  length  = 17
  special = false
}

resource "aws_db_instance" "mydb" {
  allocated_storage       = 20 # gigabytes
  apply_immediately       = true
  backup_retention_period = 0  # in days
  db_subnet_group_name    = aws_db_subnet_group.default.name
  engine                  = "postgres"
  engine_version          = "14.3"
  identifier              = "mydb"
  instance_class          = "db.t3.micro"
  multi_az                = true
  db_name                 = "mydb"
  parameter_group_name    = aws_db_parameter_group.example.name
  password                = random_password.password.result
  port                    = 5432
  publicly_accessible     = false
  skip_final_snapshot     = true
  storage_encrypted       = true # you should always do this
  storage_type            = "gp2"
  username                = "mydb"
  vpc_security_group_ids  = [aws_security_group.mysg.id]
}
