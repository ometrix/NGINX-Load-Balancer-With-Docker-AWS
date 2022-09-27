# Amazon Sercurity Group Rule
#
#resource "aws_security_group_rule" "sshmyip" {
#    protocol     = "tcp"
#    security_group_id = aws_security_group.my_security_group.id
#    from_port    = 22
#    to_port      = 22
#    type = "ingress"
#    cidr_blocks = ["179.6.214.92/32"]
#}
#
#resource "aws_security_group_rule" "https" {
#    protocol     = "tcp"
#    security_group_id = aws_security_group.my_security_group.id
#    from_port    = 443
#    to_port      = 443
#    type = "ingress"
#    cidr_blocks = ["0.0.0.0/0"]
#}
#
#resource "aws_security_group_rule" "http" {
#    protocol     = "tcp"
#    security_group_id = aws_security_group.my_security_group.id
#    from_port    = 80
#    to_port      = 80
#    type = "ingress"
#    cidr_blocks = ["0.0.0.0/0"]
#}
#
#resource "aws_security_group_rule" "output" {
#    protocol     = "tcp"
#    security_group_id = aws_security_group.my_security_group.id
#    from_port    = 0
#    to_port      = 0
#    type = "egress"
#    cidr_blocks = ["0.0.0.0/0"]
#}