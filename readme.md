# AWS Provider

useful terraform modules 

## `modules/ec2`
it will create ubuntu 16.04 backed instance and will be provisioned with
- nginx
- nvm (latest)
- node (8.4.0) using nvm
- dummy app

### How to use

> **Note** Before continue you need to [install terraform][1] and also have configured an [aws named profile][2]

Define your resource, remember some ssh key pair should be create before

```
module "my_project" {
  source = "github.com/bixlabs/aws-provisioner/modules/ec2"
  project_id = "my_project"
  project_name = "Awesome project"
  region = "us-east-1"
  profile = "my_aws_profile"
  
  private_key_path = "~/.ssh/my-ec2-amazon-pair.pem"
  public_key = "ssh-rsa AAAAB3NzaC1yc2E... "
}

output "my_project.public_dns" {
  value = "{module.my_project.nginx_node.public_dns}"
} 
```

then `terraform plan` and `terraform apply` when you are good.

Any feedback, comment, improvement just file an issue also PR are welcome :)


[1]: https://www.terraform.io/downloads.html
[2]: http://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html