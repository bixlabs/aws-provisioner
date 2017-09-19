provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

variable "region" {}
variable "profile" {}

variable "project_name" {
  default = "Hello World"
}

variable "project_id" {
  default = "hello-world"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "private_key_path" {}
variable "public_key" {}

variable "db_name" {
  default = ${var.project_id}
}
