# AWS Cloud Network Compliance & Visibility Dashboard

## Overview
This project is a lightweight AWS network visibility and compliance auditing tool designed to provide structured insight into cloud infrastructure configurations.

The system programmatically collects AWS networking resources — including VPCs, subnets, route tables, security groups, and EC2 instances — and stores them in a relational PostgreSQL database hosted on AWS RDS. Once ingested, the data is evaluated against a series of defined compliance checks to identify potential security and configuration risks.

The objective of this project is to demonstrate:
- Practical use of AWS APIs via boto3
- Structured relational data modeling for infrastructure resources
- Automated compliance analysis using SQL and Python
- Clear separation between data collection, analysis, and reporting layers
- Operational thinking aligned with remote infrastructure support environments

Rather than relying on manual console inspection, this tool emphasizes automation, repeatability, and centralized visibility — concepts essential for maintaining cloud network posture at scale.

The architecture is intentionally modular, allowing additional compliance checks, multi-account support, or dashboard integrations to be added without redesigning the core system.

## Why this Matters
As organizations migrate workloads to the cloud, network complexity increases rapidly. VPC segmentation, routing policies, security group rules, and public exposure points can expand beyond what is easily validated through manual console inspection.

Misconfigurations such as overly permissive security groups, unintended public subnets, unused resources, or default network dependencies are common sources of security risk and operational instability.

This project addresses that challenge by:
- Converting live AWS network infrastructure into structured relational data
- Enabling repeatable compliance checks rather than one-time manual reviews
- Separating data ingestion from analysis for maintainability
- Supporting consistent visibility across environments
- Demonstrating how automation can reduce configuration drift and security exposure

In virtual infrastructure environments, engineers rely on telemetry, structured data, and automation rather than physical access or ad hoc inspection. Tools like this reinforce a shift from reactive troubleshooting toward proactive governance and visibility.

By modeling AWS networking resources relationally and applying systematic compliance checks, this project reflects the operational discipline required to manage cloud infrastructure responsibly and at scale.

## Tech Stack
- Python
- boto3
- PostgreSQL (AWS RDS)
- SQLAlchemy
- Flask

## Architecture
See architecture.png

## Setup
1. Configure AWS profile/credentials
2. Configure .env
3. Run schema.sql
4. python run_collectors.py
5. python run_scan.py
6. python api/app.py

## Output Example
- Security group open to 0.0.0.0/0
- Public EC2 with public IP
- Default VPC detected

## How to use
1. Create and activate a Python virtual environment, then install the required dependencies listed in the requirements file.
2. Configure your AWS credentials using the AWS CLI. Verify access by confirming you can query your AWS account successfully.
3. Create a PostgreSQL database using AWS RDS (recommended) or a local PostgreSQL instance.
4. Copy the provided .env.example file, rename it to .env, and update it with your database credentials and AWS region.
5. Ensure your RDS security group allows inbound access from your IP address on port 5432.
6. Initialize the database by running the SQL schema file located in the db directory. This creates all required tables.
7. Run the data collection script. This pulls live AWS networking resources such as VPCs, subnets, route tables, security groups, and EC2 instances, and stores them in the database.
8. Execute the compliance scan script. The system analyzes stored resources and generates security and network compliance findings.
9. Review findings directly in the terminal output or query the compliance_findings table in PostgreSQL.

(Optional) Start the Flask API to expose findings through a local endpoint for dashboard integration or JSON review.

## General Workflow
- Configure environment/credentials
- Collect AWS resource data/Run collectors
- Run compliance scan
- Review findings
- Remediate issues in AWS
- Re-run scan to verify compliance

## Troubleshooting 
Connection Refused to RDS:
- Check security group inbound rules
- Verify RDS is publicly accessible (if testing locally)

boto3 Authentication Error:
- Run aws sts get-caller-identity
- Confirm credentials and region

### Version History:
2-16-2026: Initial repo and deployment 
2-16=2026: Initial environment deployed
