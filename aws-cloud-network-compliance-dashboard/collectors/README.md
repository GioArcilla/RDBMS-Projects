# Important
Verify that your schema supports:
- routes table
- security_groups_rules table
- ec2_instances.has_public_ip
- Foreign key relationships to vpcs and subnets

If you get a foreign key errors, it usually means:
You rand colectors before VPC/Subnet collectors.

# Best order to run
1) VPC collector
2) Subnet Collector
3) Route table collector
4) Security group collector
5) EC2 collector
