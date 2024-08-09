resource "aws_spot_instance_request" "workstation" {
  ami                    = data.aws_ami.centos8.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_all_1.id]
  spot_type              = "persistent"
  wait_for_fulfillment   = true

  tags = {
    Name = "workstation"
    Environment = "dev"
  }
}


resource "aws_ec2_tag" "name" {
  resource_id = aws_spot_instance_request.workstation.spot_instance_id
  key         = "Name"
  value       = "workstation"
}

resource "aws_ec2_tag" "environment" {
  resource_id = aws_spot_instance_request.workstation.spot_instance_id
  key         = "Environment"
  value       = "dev"
}


resource "aws_ec2_tag" "auto_instance_scheduler" {
  resource_id = aws_spot_instance_request.workstation.spot_instance_id
  key         = "Auto-instance-scheduler"
  value       = "yes"
}

