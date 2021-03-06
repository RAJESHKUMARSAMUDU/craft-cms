variable "region" {
  default     = "us-east-1"
  description  = "AWS Region"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description  = "VPC CIDR BLOCK"
}

variable "public_subnet-1_cidr" {
  default     = "10.0.1.0/24"
  description = "public subent1 cidr"
}

variable "public_subnet-2_cidr" {
  default     = "10.0.2.0/24"
  description = "public subent2 cidr"
}

variable "public_subnet-3_cidr" {
  default     = "10.0.3.0/24"
  description = "public subent3 cidr"
}

variable "private_subnet-1_cidr" {
  default     = "10.0.4.0/24"
  description = "private subent1 cidr"
}

variable "private_subnet-2_cidr" {
  default     = "10.0.5.0/24"
  description = "private subent2 cidr"
}

variable "private_subnet-3_cidr" {
  default     = "10.0.6.0/24"
  description = "private subent3 cidr"
}

variable "ecr_name" {
  description = "ECR name"
  default     = "craftcms-terraform"
}

variable "name" {
  description = "Task Exection Role"
  default     = "craftcms"
}

variable "container_port" {
  description = "Port of container"
  default     = 80
}

variable "container_cpu" {
  description = "The number of cpu units used by the task"
  default     = 512
}

variable "container_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = 1024
}

variable "container_image" {
  description = "Docker image to be launched"
  default     = "706205005497.dkr.ecr.us-east-1.amazonaws.com/craftcms-terraform"
}


variable "service_desired_count" {
  description = "Number of services running in parallely"
  default     = 2
}

variable "db_instance" {
  default = "db.t2.micro"
}
