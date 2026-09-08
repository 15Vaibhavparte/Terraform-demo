# resource local_file my_file{
#     filename  = "automate.txt"
#     content = "vaibhav-devops"
# }


# resource "aws_s3_bucket" "my_bucket" {
#     bucket = "vaibhav-parte15-bucket"
#     versioning {
#         enabled = false
#     }
# }   

#defalut vpc
data "aws_vpc" "default" {
  cidr_block = "172.31.0.0/16"

}

resource  "aws_subnet" "my_subnet" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = "172.31.49.0/24"
  map_public_ip_on_launch = true
   
   tags = {
    Name = "terra-subnet"
   }
}

# resource "aws_internet_gateway" "my_igw" {
#   vpc_id = data.aws_vpc.default.id
# }


# data "aws_route_table" "my_route_table" {
#   vpc_id = data.aws_vpc.default.id
# }

# resource "aws_route_table_association" "my_route_table_association" {
#   subnet_id      = aws_subnet.my_subnet.id
#   route_table_id = data.aws_route_table.my_route_table.id
# }


data "aws_key_pair" "my_key" {
  key_name = "gitops"
}


data "aws_security_group" "existing_sg"{
    name = "launch-wizard-4"
    vpc_id = data.aws_vpc.default.id
} 
# create ec2 instnce

resource "aws_instance" "my_instance" {
  for_each = tomap({ 
    terra-server-micro = "t3.micro"
    terra-server-medium = "t3.medium"
  })
  ami           = var.ami_id
  key_name      = data.aws_key_pair.my_key.key_name
  instance_type = each.value
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  subnet_id = aws_subnet.my_subnet.id
  user_data = file("resource.sh")

  root_block_device {
    volume_size = var.env == "prd" ? 20 : var.root_block_default_device_size
    volume_type = "gp3"
  }

   tags = {
    Name = each.key
  } 
}

 


