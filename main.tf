# Proveedor Amazon Web Services
provider "aws" {
  region = "us-east-1"
}

# Script de inicio de sistema

data "template_file" "user_data" {
  template = file("userdata.tpl")
}

data "template_file" "lb_data" {
  template = file("loadbalancerdata.tpl")
}

# Amazon Virtual Private Cloud

resource "aws_vpc" "main_vpc" {
  cidr_block = "172.31.0.0/16"

  tags = {
    name = "primerVPC"
  }
}

# Internet GateWay

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    name = "gatewayNginx"
  }
}

# Subred

resource "aws_subnet" "nginx1_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "172.31.32.0/20"
    availability_zone = "us-east-1a"

    depends_on = [aws_internet_gateway.gw]

    map_public_ip_on_launch = true

    tags = {
       Name = "nginx1"
    }
}

resource "aws_subnet" "nginx2_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "us-east-1b"

  depends_on = [aws_internet_gateway.gw]

  map_public_ip_on_launch = true

  tags = {
    Name = "nginx2"
  }
}

resource "aws_subnet" "lb_nginx_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "172.31.64.0/20"
  availability_zone = "us-east-1c"

  depends_on = [aws_internet_gateway.gw]

  map_public_ip_on_launch = true

  tags = {
    Name = "Lb_nginx"
  }
}

# Enrutamiento a internet de la instancia web

resource "aws_route_table" "web1_route_table" {
  vpc_id = aws_vpc.main_vpc.id

#  route {
#    cidr_block = "172.31.0.0/16"
#    network_interface_id = aws_instance.web.primary_network_interface_id
#  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "web1_out"
  }
}

resource "aws_route_table" "web2_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  #  route {
  #    cidr_block = "172.31.0.0/16"
  #    network_interface_id = aws_instance.web.primary_network_interface_id
  #  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "web2_out"
  }
}

resource "aws_route_table" "lb_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  #  route {
  #    cidr_block = "172.31.0.0/16"
  #    network_interface_id = aws_instance.web.primary_network_interface_id
  #  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "lb_out"
  }
}

# Asociacion de tabla de routing a la subnet de la instancia web

resource "aws_route_table_association" "a" {
  subnet_id = aws_subnet.nginx1_subnet.id
  route_table_id = aws_route_table.web1_route_table.id
}

resource "aws_route_table_association" "b" {
  subnet_id = aws_subnet.nginx2_subnet.id
  route_table_id = aws_route_table.web2_route_table.id
}

resource "aws_route_table_association" "c" {
  subnet_id = aws_subnet.lb_nginx_subnet.id
  route_table_id = aws_route_table.lb_route_table.id
}

# EC2 Ubuntu

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
#  count = 1

  key_name = "terra"

  vpc_security_group_ids = [aws_security_group.default.id]

  private_ip = "172.31.32.100"
  subnet_id  = aws_subnet.nginx1_subnet.id

  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "nginx1"
  }
}

resource "aws_instance" "web2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
#  count = 1

  key_name = "terra"

  vpc_security_group_ids = [aws_security_group.default.id]

  private_ip = "172.31.48.100"
  subnet_id  = aws_subnet.nginx2_subnet.id

  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "nginx2"
  }
}

resource "aws_instance" "lb" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
#  count = 1

  key_name = aws_key_pair.terra.key_name

  vpc_security_group_ids = [aws_security_group.default.id]

  private_ip = "172.31.64.100"
  subnet_id  = aws_subnet.lb_nginx_subnet.id

  user_data = data.template_file.lb_data.rendered

  tags = {
    Name = "lb"
  }
}

# Ip elastica asociada a la instancia WEB

#resource "aws_eip" "bar" {
#  vpc = true
#
#  instance                  = aws_instance.web.id
#  associate_with_private_ip = "10.1.1.100"
#  depends_on                = [aws_internet_gateway.gw]
#}

# Mostrar la Ip publica al terminar

output "ip_web" {
  value = aws_instance.web.public_ip
}

output "ip_web2" {
  value = aws_instance.web2.public_ip
}

output "ip_lb" {
  value = aws_instance.lb.public_ip
}