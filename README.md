# Sample Terraform Project

This project contains Terraform configurations to manage infrastructure for a sample application. The infrastructure includes resources such as VPC, ECS, ALB, ACM, Route53, and more.

## **Approach**

1. **Modular Design**: The project is structured into reusable modules, each responsible for managing a specific AWS resource. This modular design promotes reusability and maintainability.
2. **Environment-Specific Configurations**: The development directory contains configurations specific to the development environment. This allows for easy management of different environments (e.g., staging, production) by creating similar directories for each environment.
3. **GitHub Actions Integration**: The project leverages GitHub Actions for continuous integration and deployment. The workflow defined in terraform.yaml ensures that infrastructure changes are automatically validated and applied when changes are pushed or pull requests are created.
4. **State Management**: Terraform state is managed using an S3 backend, ensuring that the state is stored securely and can be shared among team members.
5. **Security**: Sensitive information such as AWS credentials and Terraform state bucket name are stored as GitHub secrets, ensuring that they are not exposed in the codebase.

## Project Structure
```
.
├── README.md
├── environments
│   └── development
│       ├── acm.tf
│       ├── alb.tf
│       ├── data.tf
│       ├── ecr.tf
│       ├── ecs.tf
│       ├── github-oidc.tf
│       ├── local.tf
│       ├── providers.tf
│       ├── route53.tf
│       ├── vpc.tf
│       └── vpce.tf
└── modules
    ├── acm
    │   ├── main.tf
    │   ├── output.tf
    │   └── vars.tf
    ├── alb
    │   ├── main.tf
    │   ├── output.tf
    │   └── vars.tf
    ├── ecr
    │   ├── lifecycle_policy.json
    │   ├── main.tf
    │   ├── output.tf
    │   └── vars.tf
    ├── ecs
    │   ├── data.tf
    │   ├── main.tf
    │   ├── output.tf
    │   └── var.tf
    ├── github-oidc
    │   ├── main.tf
    │   ├── output.tf
    │   └── vars.tf
    ├── route53
    │   ├── main.tf
    │   ├── output.tf
    │   └── vars.tf
    ├── security-group
    │   ├── main.tf
    │   ├── output.tf
    │   └── var.tf
    ├── vpc
    │   ├── data.tf
    │   ├── local.tf
    │   ├── main.tf
    │   ├── output.tf
    │   └── vars.tf
    └── vpce
        ├── main.tf
        ├── output.tf
        └── vars.tf
```

### Development Environment Components

The `environments/development` directory includes the following components:

- **acm.tf**: Configuration for AWS Certificate Manager (ACM).
- **alb.tf**: Configuration for Application Load Balancer (ALB).
- **data.tf**: Data sources for AWS resources.
- **ecr.tf**: Configuration for Elastic Container Registry (ECR).
- **ecs.tf**: Configuration for Elastic Container Service (ECS).
- **github-oidc.tf**: Configuration for GitHub OIDC provider.
- **local.tf**: Local variables for the development environment.
- **providers.tf**: Provider configurations.
- **route53.tf**: Configuration for Route53 DNS.
- **vpc.tf**: Configuration for Virtual Private Cloud (VPC).
- **vpce.tf**: Configuration for VPC Endpoints.

### Modules

#### ACM Module

- **Purpose**: Manages AWS Certificate Manager (ACM) certificates.
- **Input**:
  - `domain_name`: A domain name for which the certificate should be issued.
  - `zone_id`: The ID of the hosted zone to contain this record.
  - `subject_alternative_names`: A list of domains that should be SANs in the issued certificate.
  - `tags`: A mapping of tags to assign to the resource.
- **Includes**: ACM certificate resource.
- **Output**:
  - `acm_certificate_arn`: The ARN of the certificate.

#### ALB Module

- **Purpose**: Manages Application Load Balancer (ALB) resources.
- **Input**:
  - `name`: The name of the LB.
  - `vpc_id`: Identifier of the VPC where the security group will be created.
  - `enable_deletion_protection`: If `true`, deletion of the load balancer will be disabled via the AWS API.
  - `access_logs`: Map containing access logging configuration for load balancer.
  - `security_group_ingress_rules`: Security group ingress rules to add to the security group created.
  - `security_group_egress_rules`: Security group egress rules to add to the security group created.
  - `subnets`: A list of subnet IDs to attach to the LB.
  - `listeners`: Map of listener configurations to create.
  - `target_groups`: Map of target group configurations to create.
  - `tags`: A map of tags to add to all resources.
- **Includes**: ALB, listeners, target groups, security groups.
- **Output**:
  - `id`: The ID and ARN of the load balancer.
  - `arn`: The ARN of the load balancer.
  - `arn_suffix`: ARN suffix of the load balancer.
  - `dns_name`: The DNS name of the load balancer.
  - `zone_id`: The zone_id of the load balancer.
  - `listeners`: Map of listeners created and their attributes.
  - `listener_rules`: Map of listeners rules created and their attributes.
  - `target_groups`: Map of target groups created and their attributes.
  - `security_group_arn`: Amazon Resource Name (ARN) of the security group.
  - `security_group_id`: ID of the security group.

#### ECR Module

- **Purpose**: Manages Elastic Container Registry (ECR) resources.
- **Input**:
  - `ecr_policy`: ECR repository policy.
  - `ecr_repo_name`: ECR repository name.
  - `repo_policy_enable`: Whether or not to enable ECR repository policy.
  - `repo_lifecycle_enable`: Whether or not to enable ECR repository lifecycle policy.
  - `retention_image_number`: ECR repository lifecycle retention.
  - `scan_on_push`: Whether or not to enable scan on push image.
  - `tags`: Resource tags.
- **Includes**: ECR repository, repository policy, lifecycle policy.
- **Output**:
  - `ecr_repo_arn`: ECR repository ARN.
  - `ecr_repo_url`: ECR repository URL.

#### ECS Module

- **Purpose**: Manages Elastic Container Service (ECS) resources.
- **Input**:
  - `cluster_name`: ECS Cluster name.
  - `fargate_capacity_providers`: Map of Fargate capacity provider definitions to use for the cluster.
  - `service_name`: ECS Service name.
  - `service_cpu`: ECS Service CPU.
  - `service_memory`: ECS Service Memory.
  - `container_name`: ECS Container name.
  - `container_cpu`: ECS Container CPU.
  - `container_memory`: ECS Container Memory.
  - `container_image_url`: ECS Container image URL.
  - `container_port`: ECS Container port.
  - `alb_target_group_arn`: ALB target group ARN.
  - `subnet_ids`: List of subnet IDs.
  - `security_group_rules`: ECS service security group rules.
  - `tags`: List of resource tags.
- **Includes**: ECS cluster, services, task definitions, CloudWatch log group.
- **Output**:
  - `cluster_id`: ECS cluster ID.
  - `cluster_arn`: ECS cluster ARN.
  - `services`: Map of services created and their attributes.
  - `task_exec_iam_role_arn`: Task execution IAM role ARN.

#### GitHub OIDC Module

- **Purpose**: Manages GitHub OIDC provider and role.
- **Input**:
  - `repositories`: List of GitHub repositories.
  - `policy_arns`: List of IAM policies to attach to GitHub OIDC role.
  - `role_name`: GitHub OIDC role name.
  - `tags`: A map of tags.
- **Includes**: OIDC provider, IAM role.
- **Output**:
  - `oidc_provider_arn`: The ARN of the OIDC Provider.
  - `oidc_role`: The OIDC Role.

#### Route53 Module

- **Purpose**: Manages Route53 DNS resources.
- **Input**:
  - `domain_name`: Hosted Zone Domain name.
  - `records`: List of Route53 records.
  - `tags`: List of resource tags.
- **Includes**: Route53 zones, records.
- **Output**:
  - `route53_zone_zone_id`: Zone ID of Route53 zone.
  - `route53_zone_zone_arn`: Zone ARN of Route53 zone.
  - `route53_zone_name_servers`: Name servers of Route53 zone.
  - `route53_zone_name`: Name of Route53 zone.

#### Security Group Module

- **Purpose**: Manages security groups.
- **Input**:
  - `name`: Security group name.
  - `vpc_id`: VPC ID.
  - `ingress_with_cidr_blocks`: Security group ingress with CIDR blocks.
  - `ingress_with_source_security_group_id`: Security group ingress with source security group ID.
  - `egress_with_cidr_blocks`: Security group egress with CIDR blocks.
  - `egress_with_source_security_group_id`: Security group egress with source security group ID.
  - `ingress_with_self`: Security group ingress with self.
  - `egress_with_self`: Security group egress with self.
  - `tags`: List of resource tags.
- **Includes**: Security group with ingress and egress rules.
- **Output**:
  - `security_group_arn`: The ARN of the security group.
  - `security_group_id`: The ID of the security group.

#### VPC Module

- **Purpose**: Manages Virtual Private Cloud (VPC) resources.
- **Input**:
  - `vpc_cidr`: The IPv4 CIDR block for the VPC.
  - `name`: Name to be used on all the resources as identifier.
  - `enable_nat_gateway`: Should be true if you want to provision NAT Gateways for each of your private networks.
  - `single_nat_gateway`: Should be true if you want to provision a single shared NAT Gateway across all of your private networks.
  - `vpc_flow_log_iam_role_use_name_prefix`: Determines whether the IAM role name (`vpc_flow_log_iam_role_name_name`) is used as a prefix.
  - `enable_flow_log`: Whether or not to enable VPC Flow Logs.
  - `create_flow_log_cloudwatch_log_group`: Whether to create CloudWatch log group for VPC Flow Logs.
  - `create_flow_log_cloudwatch_iam_role`: Whether to create IAM role for VPC Flow Logs.
  - `flow_log_max_aggregation_interval`: The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record.
  - `tags`: A map of tags to add to all resources.
- **Includes**: VPC, subnets, route tables, NAT gateways, VPC Flow Logs.
- **Output**:
  - `vpc_id`: The ID of the VPC.
  - `azs`: VPC availability zones.
  - `vpc_arn`: The ARN of the VPC.
  - `vpc_cidr_block`: The CIDR block of the VPC.
  - `private_subnets`: List of IDs of private subnets.
  - `public_subnets`: List of IDs of public subnets.
  - `private_route_table_ids`: List of IDs of private route tables.
  - `public_route_table_ids`: List of IDs of public route tables.

#### VPC Endpoint (VPCE) Module

- **Purpose**: Manages VPC Endpoints.
- **Input**:
  - `vpc_id`: The ID of the VPC in which the endpoint will be used.
  - `create_security_group`: Determines if a security group is created.
  - `security_group_name`: Name to use on security group created.
  - `security_group_description`: The description of the security group.
  - `security_group_rules`: Security group rules to add to the security group created.
  - `security_group_tags`: A map of additional tags to add to the security group created.
  - `endpoint`: A map of interface and/or gateway endpoints containing their properties and configurations.
  - `tags`: A map of tags to use on all resources.
- **Includes**: VPC endpoints, security groups.
- **Output**:
  - `endpoints`: Array containing the full resource object and attributes for all endpoints created.
  - `security_group_arn`: Amazon Resource Name (ARN) of the security group.
  - `security_group_id`: ID of the security group.

## GitHub Actions Workflow

The project includes a GitHub Actions workflow to manage Terraform infrastructure changes. The workflow is defined in [terraform.yaml](https://www.notion.so/.github/workflows/terraform.yaml) and is triggered on push or pull request to the `main` branch. It includes three main jobs: `terraform-plan`, `approval-gate`, and `terraform-apply`.

### Jobs and Steps

1. **`terraform-plan`**:
This job is responsible for planning the Terraform changes.
- Checkout the repository:
    
  ```yaml
  - name: Checkout the repository
    uses: actions/checkout@v2
  ```
    
- Setup Terraform:
    
  ```yaml
  - name: Setup Terraform
    uses: hashicorp/setup-terraform@v2
    with:
      terraform_version: 1.10.2
  ```
    
- Initialize Terraform(read `tfstate` from S3 remote backend):
    
  ```yaml
  - name: Terraform init
    id: init
    run: terraform init -backend-config="bucket=$BUCKET_TF_STATE"
  ```
    
- Format Terraform files:
    
  ```yaml
  - name: Terraform format
    id: fmt
    run: terraform fmt -check
  ```
    
- Validate Terraform configuration:
    
    ```yaml
    - name: Terraform validate
      id: validate
      run: terraform validate
    ```
    
- Plan Terraform changes:
    
    ```yaml
    - name: Terraform plan
      id: plan
      if: github.event_name == 'pull_request'
      run: terraform plan -no-color -input=false
      continue-on-error: true
    ```
    
7. **Apply Terraform changes**:
    
    ```yaml
    - name: Terraform Apply
      if: github.ref == 'refs/heads/main' && github.event_name == 'push'
      run: terraform apply -auto-approve -input=false
    ```
    

This workflow ensures that Terraform configurations are properly formatted, validated, and applied when changes are pushed or pull requests are created for the `main` branch.

