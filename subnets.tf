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

resource "aws_subnet" "sn_private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "sn_private_${count.index}"
  }
}
