# aws-labs
A repo for various labs and experiments in AWS. 

## AWS Certified Advanced Networking Specialty
##### Labs & Exam Prep

**Exercise 2.1 - Create a custom VPC**
> "Create a VPC with an IPv4 CIDR block equal to 192.168.0.0/16, an AWS-provided IPv6 CIDR block, a name tag **My First VPC** and default tenancy.
- [x] Created in networking\first-vpc terraform files.

**Exercise 2.2 - Create two subnets for the custom VPC**
> 1. "Create a subnet in the VPC from exercise 2.1 and specify an AZ for it. Set the subnet IPv4 CIDR block equal to 192.168.1.0/24 and IPv6 CIDR block to subnet ID 01. Use a name tag of **Public Subnet**"
> 2. "As above, but increment CIDR blocks appropriately. This will be **Private Subnet**"
- [x] Modified networking\first-vpc\main.tf
- [ ] Used cidrsubnet function to create dynamic IPv6 cidr ranges... not sure how to create subnet IDs in terraform. 

**Exercise 2.3 - Connect the Custom VPC to the internet and establish routing**
> 1. "Create an Internet Gateway with a name tag of **IGW** and attach to the custom VPC"
> 2. "Add IPv4 and IPv6 routes to the main route table for the custom VPC that directs internet traffic (0.0.0.0/0 & ::/0) to the IGW"
> 3. "Create a NAT Gateway, place it in the public subnet and assign an elastic IP address to it"
> 4. "Create an EIGW for the VPC"
> 5. "Create a new route table with a name tag of **Private Route Table** and place in the custom VPC. Add a route to direct IPv4 Internet traffic to the NAT gateway and IPv6
traffic to the EIGW. Associate the route table with the private subnet"
- [x] Modified networking\first-vpc\main.tf
