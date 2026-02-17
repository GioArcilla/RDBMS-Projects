import boto3
from db.database import engine


def collect_route_tables(region):
    ec2 = boto3.client("ec2", region_name=region)
    response = ec2.describe_route_tables()

    with engine.begin() as conn:
        for rt in response["RouteTables"]:
            route_table_id = rt["RouteTableId"]
            vpc_id = rt["VpcId"]

            # Insert route table
            conn.execute(
                """
                INSERT INTO route_tables (route_table_id, vpc_id)
                VALUES (%s, (SELECT id FROM vpcs WHERE vpc_id = %s))
                ON CONFLICT (route_table_id) DO NOTHING;
                """,
                (route_table_id, vpc_id),
            )

            # Insert routes
            for route in rt.get("Routes", []):
                destination = route.get("DestinationCidrBlock")
                target = (
                    route.get("GatewayId")
                    or route.get("NatGatewayId")
                    or route.get("TransitGatewayId")
                    or route.get("VpcPeeringConnectionId")
                )

                if destination:
                    conn.execute(
                        """
                        INSERT INTO routes (route_table_id, destination_cidr, target)
                        VALUES (
                            (SELECT id FROM route_tables WHERE route_table_id = %s),
                            %s,
                            %s
                        )
                        ON CONFLICT DO NOTHING;
                        """,
                        (route_table_id, destination, target),
                    )
