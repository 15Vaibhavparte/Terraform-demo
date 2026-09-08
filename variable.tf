variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "ami_id" {
  type = string
  default = "ami-01a00762f46d584a1"
}

variable  "root_block_default_device_size" {
  type = number
  default = 10
}

variable "env" {
  type = string
  default = "prd"
}