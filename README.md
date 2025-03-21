# vpc-tf
define a vpc structure with public and pvt subnets and a nginx web server listening on port 80 and reachable by SSH.
# deploy sequence
Create VPC
Create Subnets, route tables, routes (public, private)
Create EC2 instance with associated Security group.
Create SSH key pair for EC2 access.
