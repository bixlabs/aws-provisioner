resource "aws_instance" "nginx_node" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = true

  key_name = "${aws_key_pair.deployer-key.key_name}"
  security_groups = ["${aws_security_group.node_nginx.name}"] // node-nginx

  tags {
    Name = "${var.project_name} [staging]"
    Description = "Created with aws-provisioner for ${var.project_name}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/provision"
    ]
  }

  provisioner "file" {
    source = "${path.module}/../provision/"
    destination = "/home/ubuntu/provision/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/provision/*",
      "/home/ubuntu/provision/install_ubuntu_build_essential.sh",
      "/home/ubuntu/provision/install_nvm.sh",
      "/home/ubuntu/provision/install_dummy_app.sh",
      "/home/ubuntu/provision/install_nginx.sh",
      "/home/ubuntu/provision/install_postgres.sh ${var.db_name}",
    ]
  }

  connection {
    user = "ubuntu"
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
  }
}

output "nginx_node.public_dns" {
  value = "${aws_instance.nginx_node.public_dns}"
}

output "nginx_node.public_ip" {
  value = "${aws_instance.nginx_node.public_ip}"
}
