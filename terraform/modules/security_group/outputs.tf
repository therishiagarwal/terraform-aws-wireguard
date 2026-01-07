output "security_group_id" {
  description = "ID of the WireGuard security group."
  value       = aws_security_group.wireguard.id
}
