.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/drivers/aws/
.. doc version: 1.9
.. check date: 2016/01/23
.. -----------------------------------------------------------------------------

.. Amazon Web Services

.. _driver-amazon-web-services:

=======================================
Amazon Web Services
=======================================

Create machines on Amazon Web Services. To create machines on Amazon Web Services, you must supply three required parameters:

    Access Key ID
    Secret Access Key
    VPC ID

Obtain your IDs and Keys from AWS. To find the VPC ID:

    Login to the AWS console
    Go to Services -> VPC -> Your VPCs.
    Locate the VPC ID you want from the VPC column.

    Go to Services -> VPC -> Subnets. Examine the Availability Zone column to verify that zone a exists and matches your VPC ID.

    For example, us-east1-a is in the a availability zone. If the a zone is not present, you can create a new subnet in that zone or specify a different zone when you create the machine.

To create the machine instance, specify --driver amazonec2 and the three required parameters.

$ docker-machine create --driver amazonec2 --amazonec2-access-key AKI******* --amazonec2-secret-key 8T93C********* --amazonec2-vpc-id vpc-****** aws01

This example assumes the VPC ID was found in the a availability zone. Use the--amazonec2-zone flag to specify a zone other than the a zone. For example, --amazonec2-zone c signifies us-east1-c.
Options

    --amazonec2-access-key: required Your access key id for the Amazon Web Services API.
    --amazonec2-secret-key: required Your secret access key for the Amazon Web Services API.
    --amazonec2-session-token: Your session token for the Amazon Web Services API.
    --amazonec2-ami: The AMI ID of the instance to use.
    --amazonec2-region: The region to use when launching the instance.
    --amazonec2-vpc-id: required Your VPC ID to launch the instance in.
    --amazonec2-zone: The AWS zone to launch the instance in (i.e. one of a,b,c,d,e).
    --amazonec2-subnet-id: AWS VPC subnet id.
    --amazonec2-security-group: AWS VPC security group name.
    --amazonec2-instance-type: The instance type to run.
    --amazonec2-root-size: The root disk size of the instance (in GB).
    --amazonec2-iam-instance-profile: The AWS IAM role name to be used as the instance profile.
    --amazonec2-ssh-user: SSH Login user name.
    --amazonec2-request-spot-instance: Use spot instances.
    --amazonec2-spot-price: Spot instance bid price (in dollars). Require the --amazonec2-request-spot-instance flag.
    --amazonec2-private-address-only: Use the private IP address only.
    --amazonec2-monitoring: Enable CloudWatch Monitoring.

By default, the Amazon EC2 driver will use a daily image of Ubuntu 14.04 LTS.
