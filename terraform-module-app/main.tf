
# dev infrastructure
module "dev-infra" {
  source         = "./infra-app"
  env            = "dev"
  bucket_name    = "vaibhav15-infra-app"
  instance_count = 1
  ami_id         = "ami-01a00762f46d584a1"
  instance_type  = "t3.micro"
  hash_key       = "studentID"
}

# stg infrastructure
module "stg-infra" {
  source         = "./infra-app"
  env            = "stg"
  bucket_name    = "vaibhav15-infra-app"
  instance_count = 1
  ami_id         = "ami-01a00762f46d584a1"
  instance_type  = "t3.micro"
  hash_key       = "studentID"
}

# prd infrastructure
module "prd-infra" {
  source         = "./infra-app"
  env            = "prd"
  bucket_name    = "vaibhav15-infra-app"
  instance_count = 2
  ami_id         = "ami-01a00762f46d584a1"
  instance_type  = "t3.medium"
  hash_key       = "studentID"
}

