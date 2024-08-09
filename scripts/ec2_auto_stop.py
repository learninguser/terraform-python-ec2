import boto3
from botocore.exceptions import ClientError

def stop_instances_by_tag(tags, region):
    ec2 = boto3.client('ec2', region_name=region)
    tag_filters = [{'Name': f'tag:{key}', 'Values': [value]} for key, value in tags.items()]
    tag_filters.append({'Name': 'instance-state-name', 'Values': ['running']})  # Include only running instances
    try:
        paginator = ec2.get_paginator('describe_instances')
        page_iterator = paginator.paginate(Filters=tag_filters)
        
        instances = []
        for page in page_iterator:
            for reservation in page['Reservations']:
                for instance in reservation['Instances']:
                    instances.append(instance['InstanceId'])

        if instances:
            stop_response = ec2.stop_instances(InstanceIds=instances)
            print(f'Stopped instances: {instances}')
            return stop_response
        else:
            print('No running instances found with the specified tags.')
    except ClientError as e:
        print(f'An error occurred: {e}')
def lambda_handler(event, context):
    # Specify the tag key, value, and region
    tags = {
        'Auto-instance-scheduler': 'yes',
        'Environment': 'dev'  # Example additional tag
    }
    region = 'us-east-1'
    stop_instances_by_tag(tags, region)