resource "aws_security_group" "pub-a" {
  name = "sg_pub-a"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "sg_pub-a"
  }
}

resource "aws_security_group_rule" "sg_egress_pub-a" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pub-a.id
}

resource "aws_security_group_rule" "ingress_pub-a_22" {
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pub-a.id
}

resource "aws_security_group_rule" "ingress-pub-a-80" {
  type = "ingress"
  from_port = "80"
  to_port = "80"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pub-a.id
}

resource "aws_security_group_rule" "ingress-pub-a-80_2" {
  type = "ingress"
  from_port = "80"
  to_port = "80"
  protocol = "tcp"
  cidr_blocks = ["::/0"]
  security_group_id = aws_security_group.pub-a.id
}

resource "aws_security_group_rule" "ingress_pub-a_3000" {
  type = "ingress"
  from_port = "3000"
  to_port = "3000"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pub-a.id
}

resource "aws_security_group" "pub-a" {
  name   = "sg_pub-a"
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "sg_pub-a"
  }
}

resource "aws_security_group_rule" "egress-priv-a" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.priv-a.id
}