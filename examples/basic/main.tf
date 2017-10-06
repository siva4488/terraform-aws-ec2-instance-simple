data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}

module "myfleet" {
  source = "trung/ec2-instance-simple/aws"

  count         = "2"
  ami           = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"
  name_prefix   = "myfleet"

  tags = {
    Foo = "bar"
  }

  network_configuration = {
    subnet_ids = ""
  }

  security_configuration = {
    security_group_ids   = ""
    iam_instance_profile = ""
  }
}
