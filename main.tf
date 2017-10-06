locals {
  subnet_ids           = "${var.network_configuration["subnet_ids"]}"
  security_group_ids   = "${var.security_configuration["security_group_ids"]}"
  iam_instance_profile = "${var.security_configuration["iam_instance_profile"]}"
}

resource "aws_instance" "simple" {
  count         = "${var.count}"
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"

  subnet_id              = "${element(local.subnet_ids, count.index % length(local.subnet_ids))}"
  vpc_security_group_ids = ["${local.security_group_ids}"]
  iam_instance_profile   = "${local.iam_instance_profile}"

  tags = "${merge(
      var.tags,
      map(
        "Name", format("%s-%d", var.name_prefix, count.index + 1)
      )
    )}"
}
