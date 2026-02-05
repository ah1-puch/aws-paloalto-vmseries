# AWS Terraform Solution - Palo Alto VM-Series

This Terraform solution deploys a comprehensive Palo Alto VM-Series firewall infrastructure on AWS, including VPCs, Transit Gateway, Gateway Load Balancer (GWLB), and associated networking components.

## Architecture Overview

The solution creates a multi-tier network architecture with:

- **Firewall VPC**: Dedicated VPC hosting Palo Alto VM-Series firewalls
- **Transit Gateway**: Central routing hub for inter-VPC communication
- **Gateway Load Balancer**: Distributes traffic across firewall instances
- **Spoke VPCs**: Application/workload VPCs that route traffic through the firewall
- **IAM Roles**: Required permissions for firewall instances
- **Security Groups**: Network access controls

## Prerequisites

- **Terraform**: `< 2.0.0`
- **AWS CLI**: Configured with appropriate credentials
- **AWS Permissions**: Admin or equivalent permissions for VPC, EC2, IAM, and Transit Gateway resources
- **S3 Backend**: Update the backend configuration in `terraform-versions.tf`

## Project Structure

```
├── configuration/           # JSON configuration files
│   ├── aws-vpc-firewall.json      # Firewall VPC configuration
│   ├── aws-vpc-spokes.json        # Spoke VPCs configuration
│   ├── aws-tgw.json               # Transit Gateway configuration
│   ├── aws-ec2.json               # EC2 instances configuration
│   ├── aws-load-balancer.json     # Gateway Load Balancer config
│   ├── aws-security-groups.json   # Security groups configuration
│   ├── aws-iam.json               # IAM roles and policies
│   └── ...                        # Other configuration files
├── *.tf                     # Terraform module calls
├── config.tf               # Configuration file processing
└── terraform-versions.tf   # Provider versions and backend
```

## Configuration

The solution uses JSON configuration files in the `configuration/` directory. These files define:

- Network topology (VPCs, subnets, route tables)
- Firewall instance specifications
- Load balancer configuration
- Security group rules
- IAM policies and roles

### Key Configuration Files

- **`aws-vpc-firewall.json`**: Defines the firewall VPC with subnets across two AZs
- **`aws-vpc-spokes.json`**: Configures spoke VPCs for workloads
- **`aws-tgw.json`**: Transit Gateway and routing configuration
- **`aws-ec2.json`**: Palo Alto VM-Series instance specifications
- **`aws-load-balancer.json`**: Gateway Load Balancer configuration

## Deployment

### 1. Update Backend Configuration

Edit `terraform-versions.tf` and update the S3 backend configuration:

```hcl
backend "s3" {
  bucket       = "your-tfstate-bucket"
  key          = "networking.tfstate"
  region       = "your-region"
  use_lockfile = true
}
```

### 2. Customize Configuration

Review and update the JSON configuration files in the `configuration/` directory to match your requirements:

- Update CIDR blocks
- Adjust instance types and sizes
- Modify security group rules
- Set appropriate tags

### 3. Initialize and Deploy

```bash
# Initialize Terraform
terraform init

# Review the deployment plan
terraform plan

# Deploy the infrastructure
terraform apply
```

### 4. Post-Deployment (Optional)

For production deployments, you may want to apply additional instance state filters. See `configuration/README-load-balancer-configs.md` for details on post-deployment load balancer configuration.

## Network Architecture

### Firewall VPC (10.20.255.0/24)
- **TGW Attachment Subnets**: Connect to Transit Gateway
- **GWLB Endpoint Subnets**: Gateway Load Balancer endpoints
- **GWLB Subnets**: Gateway Load Balancer targets
- **PA Private Subnets**: Firewall private interfaces
- **PA Public Subnets**: Firewall public interfaces
- **PA Management Subnets**: Firewall management interfaces

### Traffic Flow
1. Traffic from spoke VPCs routes through Transit Gateway
2. Transit Gateway sends traffic to firewall VPC
3. Gateway Load Balancer distributes traffic across firewall instances
4. Firewalls inspect and forward traffic based on policies
5. Return traffic follows the reverse path

## Components

### Terraform Modules Called
- VPC creation and configuration
- Transit Gateway setup
- EC2 instances (Palo Alto VM-Series)
- Gateway Load Balancer
- Network interfaces and routing
- Security groups
- IAM roles and policies

### AWS Resources Created
- VPCs and subnets
- Internet and NAT gateways
- Route tables and routes
- Transit Gateway and attachments
- Gateway Load Balancer and target groups
- EC2 instances (Palo Alto VM-Series)
- Network interfaces
- Security groups
- IAM roles and instance profiles

## Customization

### Adding Spoke VPCs
Update `configuration/aws-vpc-spokes.json` to add additional spoke VPCs.

### Scaling Firewalls
Modify `configuration/aws-ec2.json` to adjust the number and size of firewall instances.

### Security Groups
Update `configuration/aws-security-groups.json` to modify network access rules.

## Troubleshooting

### Common Issues

1. **Backend Access**: Ensure the S3 bucket exists and you have permissions
2. **Resource Limits**: Check AWS service limits for VPCs, subnets, and instances
3. **CIDR Conflicts**: Ensure no overlapping CIDR blocks between VPCs
4. **Instance Types**: Verify Palo Alto VM-Series AMI availability in your region

### Logs and Debugging

- Review Terraform plan output carefully before applying
- Check AWS CloudTrail for API call logs
- Monitor Palo Alto firewall logs through the management interface

## Security Considerations

- Update default passwords after deployment
- Configure firewall policies before routing production traffic
- Implement proper backup and disaster recovery procedures
- Regularly update Palo Alto VM-Series AMI versions
- Monitor and audit network traffic flows

## Contributing

1. Follow the existing JSON configuration structure
2. Test changes in a development environment first
3. Document any new configuration options
4. Update this README for significant changes

## Support

For issues related to:
- **Terraform configuration**: Review the Terraform documentation
- **AWS services**: Consult AWS documentation and support
- **Palo Alto VM-Series**: Refer to Palo Alto Networks documentation

## License

This project follows your organization's licensing terms. Please refer to your internal documentation for specific license information. 