output "instance_public_ip" {
  description = "Public IP of the WireGuard server (client Endpoint)."
  value       = aws_instance.wireguard.public_ip
}

output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.wireguard.id
}
