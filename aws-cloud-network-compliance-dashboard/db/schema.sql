###Create Core Tables

###1) aws_accounts
CREATE TABLE aws_accounts (
    id SERIAL PRIMARY KEY,
    account_id VARCHAR(20) UNIQUE NOT NULL,
    account_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

###2) vpcs
CREATE TABLE vpcs (
    id SERIAL PRIMARY KEY,
    aws_account_id INTEGER REFERENCES aws_accounts(id),
    vpc_id VARCHAR(50) UNIQUE NOT NULL,
    cidr_block VARCHAR(50),
    is_default BOOLEAN,
    state VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

###3) subnets
CREATE TABLE subnets (
    id SERIAL PRIMARY KEY,
    vpc_id INTEGER REFERENCES vpcs(id),
    subnet_id VARCHAR(50) UNIQUE NOT NULL,
    cidr_block VARCHAR(50),
    availability_zone VARCHAR(50),
    is_public BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

###4) route tables 
CREATE TABLE route_tables (
    id SERIAL PRIMARY KEY,
    vpc_id INTEGER REFERENCES vpcs(id),
    route_table_id VARCHAR(50) UNIQUE NOT NULL
);

###5) routes
CREATE TABLE routes (
    id SERIAL PRIMARY KEY,
    route_table_id INTEGER REFERENCES route_tables(id),
    destination_cidr VARCHAR(50),
    target VARCHAR(100)
);

###6) security_groups
CREATE TABLE security_groups (
    id SERIAL PRIMARY KEY,
    vpc_id INTEGER REFERENCES vpcs(id),
    sg_id VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100),
    description TEXT
);

###7) security_group_rules
CREATE TABLE security_group_rules (
    id SERIAL PRIMARY KEY,
    sg_id INTEGER REFERENCES security_groups(id),
    protocol VARCHAR(20),
    from_port INTEGER,
    to_port INTEGER,
    cidr_block VARCHAR(50),
    direction VARCHAR(10) -- ingress / egress
);

###8) ec2_instances
CREATE TABLE ec2_instances (
    id SERIAL PRIMARY KEY,
    instance_id VARCHAR(50) UNIQUE NOT NULL,
    subnet_id INTEGER REFERENCES subnets(id),
    private_ip VARCHAR(50),
    public_ip VARCHAR(50),
    state VARCHAR(20),
    has_public_ip BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

###9) compliance_findings
CREATE TABLE compliance_findings (
    id SERIAL PRIMARY KEY,
    resource_type VARCHAR(50),
    resource_id VARCHAR(100),
    severity VARCHAR(20),
    description TEXT,
    detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
