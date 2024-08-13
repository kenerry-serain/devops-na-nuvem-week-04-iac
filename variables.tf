
variable "credentials" {
  type = object({
    region          = string
    assume_role_arn = string
  })

  default = {
    region          = "us-east-1"
    assume_role_arn = "arn:aws:iam::968225077300:role/DevOpsNaNuvemWeekRole"
  }
}

variable "tags" {
  type = object({
    Environment = string
    Project     = string
  })

  default = {
    Environment = "production"
    Project     = "devops-na-nuvem-week"
  }
}

variable "vpc" {
  type = object({
    name                     = string
    cidr_block               = string
    internet_gateway_name    = string
    nat_gateway_name         = string
    public_route_table_name  = string
    private_route_table_name = string
    public_subnets = list(object({
      name                    = string
      availability_zone       = string
      cidr_block              = string
      map_public_ip_on_launch = bool
    }))
    private_subnets = list(object({
      name                    = string
      availability_zone       = string
      cidr_block              = string
      map_public_ip_on_launch = bool
    }))
  })

  default = {
    name                     = "devops-na-nuvem-week-vpc"
    cidr_block               = "10.0.0.0/24"
    internet_gateway_name    = "devops-na-nuvem-week-vpc-internet-gateway"
    nat_gateway_name         = "devops-na-nuvem-week-vpc-nat-gateway"
    public_route_table_name  = "devops-na-nuvem-week-vpc-public-route-table"
    private_route_table_name = "devops-na-nuvem-week-vpc-private-route-table"
    public_subnets = [{
      name                    = "devops-na-nuvem-week-vpc-public-subnet-us-east-1a"
      availability_zone       = "us-east-1a"
      cidr_block              = "10.0.0.0/26"
      map_public_ip_on_launch = true
      }, {
      name                    = "devops-na-nuvem-week-vpc-public-subnet-us-east-1b"
      availability_zone       = "us-east-1b"
      cidr_block              = "10.0.0.64/26"
      map_public_ip_on_launch = true
    }]
    private_subnets = [{
      name                    = "devops-na-nuvem-week-vpc-private-subnet-us-east-1a"
      availability_zone       = "us-east-1a"
      cidr_block              = "10.0.0.128/26"
      map_public_ip_on_launch = false
      }, {
      name                    = "devops-na-nuvem-week-vpc-private-subnet-us-east-1b"
      availability_zone       = "us-east-1b"
      cidr_block              = "10.0.0.192/26"
      map_public_ip_on_launch = false
    }]
  }
}

variable "eks_cluster" {
  type = object({
    name                              = string
    role_name                         = string
    access_config_authentication_mode = string
    enabled_cluster_log_types         = list(string)
    node_group = object({
      role_name                   = string
      instance_types              = list(string)
      capacity_type               = string
      scaling_config_desired_size = number
      scaling_config_max_size     = number
      scaling_config_min_size     = number
    })
  })

  default = {
    name                              = "devops-na-nuvem-week-eks-cluster"
    role_name                         = "DevOpsNaNuvemWeekEKSClusterRole"
    access_config_authentication_mode = "API_AND_CONFIG_MAP"
    enabled_cluster_log_types = [
      "api",
      "audit",
      "authenticator",
      "controllerManager",
      "scheduler",
    ]
    node_group = {
      role_name                   = "DevOpsNaNuvemWeekEKSClusterNodeGroupRole"
      instance_types              = ["t3.medium"]
      capacity_type               = "ON_DEMAND"
      scaling_config_desired_size = 2
      scaling_config_max_size     = 2
      scaling_config_min_size     = 2
    }
  }
}

variable "ecr_repositories" {
  type = list(object({
    name                 = string
    image_tag_mutability = string
  }))

  default = [{
    name                 = "devops-na-nuvem-week/production/frontend"
    image_tag_mutability = "MUTABLE"
    }, {
    name                 = "devops-na-nuvem-week/production/backend"
    image_tag_mutability = "MUTABLE"
  }]
}
