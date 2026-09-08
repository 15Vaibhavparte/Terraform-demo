output "instance_public_ip" {
  value = [
    for instance in aws_instance.my_instance : instance.public_ip
  ]
  
}

output "instance_private_ip" {
    value = [
        for instance in aws_instance.my_instance : instance.private_ip
    ]
}

output "instance_id" {
    value = [
        for instance in aws_instance.my_instance : instance.id
    ]
}

output "instance_arn" {
    value = [
        for instance in aws_instance.my_instance : instance.arn
    ]
}
