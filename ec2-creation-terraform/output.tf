# for count argument the output will be like this
# output "ec2_public_ip" {
#   value = aws_instance.my_instance[*].public_ip
# }


# the output format for for each will be
# output "instance_public_ips" {
#   description = "Public IP addresses of the created instances."
#   value = {
#     for k, inst in aws_instance.my_instance : k => inst.public_ip
#   }
# }


output "ec2_public_ip" {
  value = aws_instance.my_instance.public_ip
}
