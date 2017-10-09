provider "aws" {
  profile = "lab"
  region = "eu-central-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_security_group" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
  name   = "default"
}

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
  // source = "trung/ec2-instance-simple/aws"
  source = "../.."

  count         = "4"
  ami           = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"
  name_prefix   = "myfleet"

  tags = {
    Foo = "bar"
  }

  network_configuration = "${map(
    "subnet_ids", join(",", data.aws_subnet_ids.all.ids),
    "enable_public", "true"
  )}"

  security_configuration = "${map(
    "security_group_ids", data.aws_security_group.default.id,
    "iam_instance_profile", ""
  )}"
}
