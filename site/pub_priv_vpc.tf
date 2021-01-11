# Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file
# except in compliance with the License. A copy of the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed on an "AS IS"
# BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under the License.
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "terraform_igw"
  }
}

resource "aws_eip" "this" {
  vpc = true
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.demo_public.id
}


#
# Public Subnet
#
resource "aws_subnet" "demo_public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = element(var.availability_zones, 0)
  tags = {
    Name = "terraform_public_subnet"
  }
}

resource "aws_route_table" "demo_public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  tags = {
    Name = "terraform_public_subnet_route_table"
  }
}

resource "aws_route_table_association" "demo_public" {
  subnet_id      = aws_subnet.demo_public.id
  route_table_id = aws_route_table.demo_public.id
}

#
# Private Subnet
#
resource "aws_subnet" "demo_private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = element(var.availability_zones, 0)
  tags = {
    Name = "terraform_private_subnet"
  }
}

resource "aws_route_table" "demo_private" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }
  tags = {
    Name = "terraform_private_subnet_route_table"
  }
}

resource "aws_route_table_association" "demo_private" {
  subnet_id      = aws_subnet.demo_private.id
  route_table_id = aws_route_table.demo_private.id
}
