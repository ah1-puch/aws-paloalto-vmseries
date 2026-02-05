# Load Balancer Configuration Files

This directory contains different load balancer configuration files for different deployment phases:

## Files

### `aws-load-balancer.json`
- **Purpose**: Initial deployment configuration
- **Usage**: Use this during the first deployment when EC2 instances don't exist yet
- **Features**: 
  - Filters instances by Name and Environment tags only
  - No instance state filtering (allows deployment before instances exist)

### `aws-load-balancer-post-deploy.json`
- **Purpose**: Post-deployment instance state filters
- **Usage**: Contains only the `instance-state-name` filters that can be merged after initial deployment
- **Features**:
  - Filters instances by "running" state
  - Can be conditionally applied after instances are deployed

## Usage Patterns

### Initial Deployment
```bash
# Use the main configuration file
terraform apply
```

### Post-Deployment (Optional State Filtering)
You can merge the configurations or conditionally apply the state filters by:

1. **Option 1**: Update your `config.tf` to conditionally include state filters
2. **Option 2**: Use the post-deploy config for subsequent operations
3. **Option 3**: Manually merge the configurations when needed

### Example Conditional Logic (for config.tf)
```hcl
locals {
  base_config = jsondecode(file("${path.module}/configuration/aws-load-balancer.json"))
  state_filters = var.include_instance_state_filter ? jsondecode(file("${path.module}/configuration/aws-load-balancer-post-deploy.json")) : { network = { datasource = { instance = {} } } }
  
  # Merge configurations
  config = {
    network = {
      datasource = {
        instance = merge(
          local.base_config.network.datasource.instance,
          {
            for k, v in local.state_filters.network.datasource.instance : k => {
              filter = concat(
                try(local.base_config.network.datasource.instance[k].filter, []),
                try(v.filter, [])
              )
            }
          }
        )
      }
      load_balancer = local.base_config.network.load_balancer
    }
    common = local.base_config.common
  }
} 