resource "aws_security_group" "node_nginx" {
  name = "${var.project_id}-node-nginx"
  description = "Machine with Nginx and Node"
  vpc_id = "${aws_vpc.selected.id}"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
