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

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.sn_public[count.index].id
  route_table_id = aws_route_table.rtbl_public.id

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
