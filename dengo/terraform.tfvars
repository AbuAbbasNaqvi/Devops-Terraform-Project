# Key pair and region
key_pair_name = "jenka"
region        = "us-west-2"
ami_id        = "ami-0b8c6b923777519db"
instance_type = "t2.micro"
storage_size  = 15

# VPC and Subnet CIDR blocks
vpc_cidr_block    = "172.31.0.0/16"
subnet_cidr_block = "172.31.64.0/24"  # Updated Subnet CIDR block to avoid conflicts

# Security group rules
allowed_ssh_cidr  = ["0.0.0.0/0"] # Allow SSH access from anywhere
allowed_http_cidr = ["0.0.0.0/0"] # Allow HTTP access from anywhere
allowed_ports     = [22, 8080]    # Open ports for SSH and HTTP
