# Interface

#resource "aws_network_interface" "foo" {
#  subnet_id   = aws_subnet.my_subnet.id
#  private_ips = ["10.1.1.100"]
#
#  tags = {
#    Name = "primary_network_interface"
#  }
#}

# asignacion de una interfaz de red a una Instancia

#resource "aws_network_interface_sg_attachment" "sg_attachment" {
#  security_group_id    = aws_security_group.my_security_group.id
#  network_interface_id = aws_instance.web.primary_network_interface_id
#}