resource "aws_key_pair" "deployer-key" {
  key_name = "${var.project_id}-key"
  public_key = "${var.public_key}"
}