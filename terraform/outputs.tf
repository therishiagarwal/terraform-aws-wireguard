output "vpn_server_public_ip" {
  description = "Public IP of the WireGuard VPN server."
  value       = module.compute.instance_public_ip
}

output "client_conf_bucket" {
  description = "S3 bucket holding the generated wg-client.conf."
  value       = module.storage.bucket_id
}

output "client_conf_bucket_arn" {
  description = "ARN of the client config bucket."
  value       = module.storage.bucket_arn
}
