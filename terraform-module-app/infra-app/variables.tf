

variable "env" {
    description = "The environment for the S3 bucket"    # we will not use default value for this variable, so that we can pass the value from the command line or from a tfvars file
    type        = string
}

variable "bucket_name" {
    description = "The name of the S3 bucket"
    type        = string
}

variable "hash_key" {
    description = "The hash key for the DynamoDB table"
    type        = string
}

variable "instance_count" {
    description = "Number of EC2 instances to create"
    type        = number
}

variable "ami_id" {
    description = "The AMI ID for the EC2 instance"
    type        = string
}

variable "instance_type" {
    description = "The instance type for the EC2 instance"
    type        = string
}

