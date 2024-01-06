resource "aws_vpc" "new-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.prefix}-vpc"
    }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnets" {
    count = 2
    availability_zone = data.aws_availability_zones.available.names[count.index]
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.0.${count.index}.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.prefix}-subnet-${count.index}"
    }
}

resource "aws_internet_gateway" "new-igw" {
    vpc_id = aws_vpc.new-vpc.id
    tags = {
        Name = "${var.prefix}-igw"
    }
}


resource "aws_route_table" "new-rtb" {
    vpc_id = aws_vpc.new-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.new-igw.id
    }
    tags = {
        Name = "${var.prefix}-rtb"
    }
}

resource "aws_route_table_association" "new-rtb-association" {
    count =2
    route_table_id = aws_route_table.new-rtb.id
    subnet_id = aws_subnet.subnets.*.id[count.index]
}


# resource "aws_vpc" "new-vpc" {
#     cidr_block = var.vpc_cidr_block
#     tags = {
#         Name = "${var.prefix}-vpc"
#     }
# }

# data "aws_availability_zones" "available" {}

# resource "aws_subnet" "public_subnets" {
#     count = 2
#     availability_zone = data.aws_availability_zones.available.names[count.index]
#     vpc_id = aws_vpc.new-vpc.id
#     cidr_block = "10.0.${count.index}.0/24"
#     map_public_ip_on_launch = true
#     tags = {
#         Name = "${var.prefix}-public-subnet-${count.index}"
#     }
# }

# resource "aws_subnet" "private_subnets" {
#     count = 2
#     availability_zone = data.aws_availability_zones.available.names[count.index]
#     vpc_id = aws_vpc.new-vpc.id
#     cidr_block = "10.0.${count.index + 2}.0/24"
#     tags = {
#         Name = "${var.prefix}-private-subnet-${count.index}"
#     }
# }

# resource "aws_internet_gateway" "new-igw" {
#     vpc_id = aws_vpc.new-vpc.id
#     tags = {
#         Name = "${var.prefix}-igw"
#     }
# }

# resource "aws_route_table" "public-rtb" {
#     vpc_id = aws_vpc.new-vpc.id
#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_internet_gateway.new-igw.id
#     }
#     tags = {
#         Name = "${var.prefix}-public-rtb"
#     }
# }

# resource "aws_route_table_association" "public-rtb-association" {
#     count          = 2
#     route_table_id = aws_route_table.public-rtb.id
#     subnet_id      = aws_subnet.public_subnets[count.index].id
# }

# resource "aws_instance" "nat" {
#     ami                    = "ami-xxxxxxxxxxxxxxxxx"  # Substitua pelo ID da AMI NAT
#     instance_type          = "t3.micro"  # Substitua pelo tipo de instância desejado
#     subnet_id              = aws_subnet.public_subnets[0].id
#     associate_public_ip_address = true
#     key_name               = "your-key-pair"  # Substitua pelo nome da chave SSH
#     tags = {
#         Name = "${var.prefix}-nat-instance"
#     }
# }

# resource "aws_route_table" "private-rtb" {
#     vpc_id = aws_vpc.new-vpc.id
#     tags = {
#         Name = "${var.prefix}-private-rtb"
#     }
# }

# resource "aws_route_table_association" "private-rtb-association" {
#     count          = 2
#     route_table_id = aws_route_table.private-rtb.id
#     subnet_id      = aws_subnet.private_subnets[count.index].id
# }

# resource "aws_route" "private-route-to-nat" {
#     count          = 2
#     route_table_id = aws_route_table.private-rtb.id
#     destination_cidr_block = "0.0.0.0/0"
#     instance_id   = aws_instance.nat.id
# }
