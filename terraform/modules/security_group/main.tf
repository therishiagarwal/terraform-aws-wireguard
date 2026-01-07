# Firewall for the VPN server: WireGuard in from anywhere, SSH from trusted IPs only.
resource "aws_security_group" "wireguard" {
  name        = "${var.name_prefix}-wireguard-sg"
  description = "Ingress for WireGuard and restricted SSH"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-wireguard-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "wireguard" {
  security_group_id = aws_security_group.wireguard.id
  description       = "WireGuard VPN"
  from_port         = var.wireguard_port
  to_port           = var.wireguard_port
  ip_protocol       = "udp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  for_each = toset(var.ssh_allowed_cidrs)

  security_group_id = aws_security_group.wireguard.id
  description       = "SSH admin access"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = each.value
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.wireguard.id
  description       = "Allow all outbound"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
