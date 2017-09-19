resource "aws_security_group" "node_nginx" {
  name = "${var.project_id}-node-nginx"
  description = "Machine with Nginx and Node"
}

resource "aws_security_group_rule" "node_nginx" {
  type = "egress"
  from_port = 0
  protocol = "-1"
  to_port = 65535
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.node_nginx.id}"
}

resource "aws_security_group_rule" "node_nginx_http" {
  from_port = 80
  protocol = "tcp"
  security_group_id = "${aws_security_group.node_nginx.id}"
  to_port = 80
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node_nginx_ssh" {
  from_port = 22
  protocol = "tcp"
  security_group_id = "${aws_security_group.node_nginx.id}"
  to_port = 22
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node_nginx_https" {
  from_port = 443
  protocol = "tcp"
  security_group_id = "${aws_security_group.node_nginx.id}"
  to_port = 443
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}