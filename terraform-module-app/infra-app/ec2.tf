#defalut vpc
data "aws_vpc" "default" {
  cidr_block = "172.31.0.0/16"

}

resource  "aws_subnet" "my_subnet" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = var.env == "dev" ? "172.31.173.0/24" : var.env == "stg" ? "172.31.174.0/24" :"172.31.175.0/24"
  map_public_ip_on_launch = true
   
   tags = {
    Name = "${var.env}-terra-subnet"
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


resource "aws_key_pair" "my_multi_key" {
  key_name = "${var.env}-multi-env-key"
  public_key = file("multi-env.pub")

}


data "aws_security_group" "existing_multi_sg"{
    name = "launch-wizard-4"
    vpc_id = data.aws_vpc.default.id

} 
# create ec2 instnce

resource "aws_instance" "my_instance" {
  count =  var.instance_count
  ami           = var.ami_id
  key_name      = aws_key_pair.my_multi_key.key_name
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.existing_multi_sg.id]
  subnet_id = aws_subnet.my_subnet.id
  

  root_block_device {
    volume_size = var.env == "prd" ? 20 : 10
    volume_type = "gp3"
  }

   tags = {
    Name = "${var.env}-my-instance-${count.index + 1}"
    Environment = var.env
  } 
}




