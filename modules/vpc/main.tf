resource "aws_vpc" "redshift_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.redshift_vpc.id

  tags = {
    Name = "redshift-vpc-igw"
  }
}


resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.redshift_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rtb-redshift-vpc"
  }
}


resource "aws_route_table_association" "rta" {
  count          = length(var.subnet_ids)
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.rtb.id
}
