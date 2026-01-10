# WireGuard VPN server. Bootstrapped entirely through user_data so the
# instance is disposable — destroy and re-apply to get a fresh server.
resource "aws_instance" "wireguard" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_id]
  iam_instance_profile        = var.instance_profile_name
  associate_public_ip_address = true

  # Pass config in rather than hardcoding it in the script, so bucket name
  # and port stay in sync with the rest of the Terraform.
  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    wireguard_port   = var.wireguard_port
    conf_bucket_name = var.conf_bucket_name
  })

  tags = {
    Name = "${var.name_prefix}-wireguard"
  }
}
