resource "aws_vpc" "test_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "test_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test_igw"
  }
}

resource "aws_route_table" "rtbl_public" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "rtbl_public"
  }
}

resource "aws_route" "rt_pub_internet" {
  route_table_id         = aws_route_table.rtbl_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

}

resource "aws_subnet" "sn_public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "sn_public_${count.index}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.sn_public[count.index].id
  route_table_id = aws_route_table.rtbl_public.id

}

resource "aws_subnet" "sn_private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "sn_private_${count.index}"
  }
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.test_vpc.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.sn_private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
