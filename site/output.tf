output "vpc_id" {
  value = aws_vpc.this.id
}

output "bastion_ssh_sg_id" {
  value = aws_security_group.bastion_ssh_sg.id
}

output "ssh_from_bastion_sg_id" {
  value = aws_security_group.ssh_from_bastion_sg.id
}

output "web_access_from_nat_sg_id" {
  value = aws_security_group.web_access_from_nat_sg.id
}

output "public_subnet_id" {
  value = aws_subnet.demo_public.id
}

output "private_subnet_id" {
  value = aws_subnet.demo_private.id
}

output "webapp_http_inbound_sg_id" {
  value = aws_security_group.webapp_http_inbound_sg.id
}

output "webapp_ssh_inbound_sg_id" {
  value = aws_security_group.webapp_ssh_inbound_sg.id
}

output "webapp_outbound_sg_id" {
  value = aws_security_group.webapp_outbound_sg.id
}
