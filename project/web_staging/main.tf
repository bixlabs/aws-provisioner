module "arbit_web_staging" {
  source = "github.com/bixlabs/aws-provisioner/modules/ec2"
  project_id = "hey-mozo"
  project_name = "Hey Mozo"
  region = "us-west-2"
  profile = "arbit"

  private_key_path = "~/.ssh/bixlabs.pem"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCOdWrk9M8xhnkvpVH5yABOA23X4h0vOui8tEwIVMhhuRi4hcAyeHQgolG7XBrTkzNKYvv+yfGKzycwnh5iQNII6WP6vEAp1g6ltlsC2oVX+gz0FiW3YU7yJ1V7csbA2mVi5eBetoflkhusYnWPbTS5NcH11+K30SXqt9j7P1T5hLXsb4ZQW81KaKpxeluWSy2VOtYJXChHS9SJ7puRBvw7WiVPDqaz/qrsWtOgmziOMMakG14BK9g9sxH88mCwbEUZn2KtKy1/ovfoMH1atduNLy1psWyAkmztsYKuy3JP02xYxaPaX/dQ6mEFThTpNGqCGNZIv24Ho8A/TC2ZdZWR bixlabs"
}

output "arbit_web_staging.public_dns" {
  value = "${module.arbit_web_staging.nginx_node.public_dns}"
}