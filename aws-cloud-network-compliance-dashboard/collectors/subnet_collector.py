import boto3
from db.database import engine

def collect_subnets(region):
    ec2 = boto3.client("ec2", region_name=region)
    response = ec2.describe_subnets()

    with engine.connect() as conn:
        for subnet in response["Subnets"]:
            conn.execute(
                """
                INSERT INTO subnets (subnet_id, cidr_block, availability_zone)
                VALUES (%s, %s, %s)
                ON CONFLICT (subnet_id) DO NOTHING;
                """,
                (
                    subnet["SubnetId"],
                    subnet["CidrBlock"],
                    subnet["AvailabilityZone"]
                )
            )
