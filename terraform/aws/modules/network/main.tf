data "aws_caller_identity" "current" {}

resource "aws_vpc" "todo_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name      = var.vpc_name
    ManagedBy = "terraform"
    Owner     = data.aws_caller_identity.current.account_id
  })
}

resource "aws_internet_gateway" "todo_igw" {
  vpc_id = aws_vpc.todo_vpc.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-igw"
  })
}

resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnet_cidrs : idx => cidr }

  vpc_id                  = aws_vpc.todo_vpc.id
  cidr_block              = each.value
  availability_zone       = var.azs[tonumber(each.key)]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name                     = "${var.vpc_name}-public-${each.key}"
    "kubernetes.io/role/elb" = "1"
  })
}

resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.private_subnet_cidrs : idx => cidr }

  vpc_id            = aws_vpc.todo_vpc.id
  cidr_block        = each.value
  availability_zone = var.azs[tonumber(each.key)]

  tags = merge(var.tags, {
    Name                              = "${var.vpc_name}-private-${each.key}"
    "kubernetes.io/role/internal-elb" = "1"
  })
}

resource "aws_eip" "nat" {
  for_each = aws_subnet.public

  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-nat-eip-${each.key}"
  })
}

resource "aws_nat_gateway" "todo_ngw" {
  for_each = aws_subnet.public

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-nat-${each.key}"
  })

  depends_on = [aws_internet_gateway.todo_igw]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.todo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.todo_igw.id
  }

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public"
  })
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = aws_nat_gateway.todo_ngw

  vpc_id = aws_vpc.todo_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.todo_ngw[each.key].id
  }

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-private-${each.key}"
  })
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}


