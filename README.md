# terraform-aws-wireguard

A self-hosted WireGuard VPN on AWS, provisioned end-to-end with Terraform.

I originally built this VPN by hand — clicking through the AWS console, SSHing
into the box, and configuring WireGuard manually. This repo is that same idea
rebuilt properly as Infrastructure as Code while I was learning Terraform, so
the whole thing comes up (and tears down) with a single `terraform apply`.

## Why self-host a VPN?

- **Privacy & control** — your traffic goes through infrastructure you own.
- **Cost** — comfortably inside the AWS Free Tier for personal use.
- **No third-party logging** — no commercial VPN provider in the path.
- **Region choice** — put the exit node wherever you need it.

## Architecture

```
                        ┌─────────────────────────────────────────┐
                        │                 AWS VPC                   │
                        │              (10.0.0.0/16)                │
   ┌──────────┐  wg     │   ┌───────────────────────────────────┐  │
   │  Your     │ :51820  │   │        Public Subnet              │  │
   │  device   │◄───────►│──►│   ┌───────────────────────────┐   │  │
   │ (client)  │  UDP    │   │   │  EC2 (Ubuntu + WireGuard) │   │  │
   └──────────┘         │   │   │  bootstrapped by user_data │   │  │
                        │   │   └───────────┬───────────────┘   │  │
                        │   └───────────────┼───────────────────┘  │
                        │        IGW  ◄─────┘  IAM role (PutObject) │
                        └──────────────────────────┼───────────────┘
                                                    ▼
                                        ┌───────────────────────┐
                                        │  S3: wg-client.conf   │
                                        │  (private, encrypted) │
                                        └───────────────────────┘
```

The EC2 instance generates the server **and** client keys on first boot, writes
`wg-client.conf`, and uploads it to a private S3 bucket. You pull that file down,
drop it into any WireGuard client, and you're connected.

## Module layout

| Module | Responsibility |
|---|---|
| `vpc` | VPC, public subnet, internet gateway, route table |
| `security_group` | WireGuard (UDP) open; SSH restricted to your CIDR |
| `iam` | EC2 role + least-privilege `s3:PutObject` policy + instance profile |
| `storage` | Private, encrypted S3 bucket for the client config |
| `compute` | EC2 instance + templated WireGuard `user_data` bootstrap |

State is stored remotely in S3, bootstrapped separately under `terraform_state/`.

## Prerequisites

- An AWS account and credentials configured locally (`aws configure`)
- Terraform >= 1.5
- An existing EC2 key pair in your target region

## Usage

**1. Bootstrap the remote-state bucket** (run once):

```bash
cd terraform_state
terraform init
terraform apply -var="state_bucket_name=wireguard-tfstate-yourname"
```

**2. Point the backend at that bucket** — set the same name in
`terraform/versions.tf` (the `backend "s3"` block).

**3. Deploy the VPN:**

```bash
cd ../terraform
cp terraform.tfvars.example terraform.tfvars   # edit with your values
terraform init
terraform apply
```

**4. Grab your client config:**

```bash
aws s3 cp s3://<your-conf-bucket>/wg-client.conf .
```

Import `wg-client.conf` into the WireGuard app and connect.

**5. Tear it all down** when you're done:

```bash
terraform destroy
```

## Notes & hardening

- `ssh_allowed_cidrs` defaults to `0.0.0.0/0` for first-run convenience —
  set it to your own IP in `terraform.tfvars`.
- The `ami_id` default is region-specific (an Ubuntu image in `ap-southeast-1`);
  change it if you deploy elsewhere.
- The client config contains a private key, so the bucket blocks all public
  access and encrypts objects at rest.

## License

MIT — see [LICENSE](LICENSE).
