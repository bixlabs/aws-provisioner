resource "aws_instance" "nginx_node" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = true
  subnet_id = "${aws_subnet.us-east-1a-public.id}"

  key_name = "${aws_key_pair.deployer-key.key_name}"
  security_groups = ["${aws_security_group.node_nginx.id}"] // node-nginx

  tags {
    Name = "${var.project_name} [demo]"
    Description = "Created with aws-provisioner for ${var.project_name}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/provision"
    ]
  }

  provisioner "file" {
    source = "${path.module}/provision/"
    destination = "/home/ubuntu/provision/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/provision/*",
      "/home/ubuntu/provision/install_ubuntu_build_essential.sh",
      "/home/ubuntu/provision/install_nvm.sh",
      "/home/ubuntu/provision/install_dummy_app.sh",
      "/home/ubuntu/provision/install_nginx.sh",
    ]
  }

  connection {
    user = "ubuntu"
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
  }
}

resource "aws_vpc" "selected" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "${var.project_name}"
  }
}

resource "aws_subnet" "us-east-1a-public" {
  vpc_id = "${aws_vpc.selected.id}"
  cidr_block = "10.0.1.0/25"
  availability_zone = "us-east-1a"
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.selected.id}"
  tags {
    Name = "${var.project_name}"
  }
}

resource "aws_default_route_table" "r" {
  default_route_table_id = "${aws_vpc.selected.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "${var.project_name}"
  }

}

output "nginx_node.public_dns" {
  value = "${aws_instance.nginx_node.public_dns}"
}

output "nginx_node.public_ip" {
  value = "${aws_instance.nginx_node.public_ip}"
}
