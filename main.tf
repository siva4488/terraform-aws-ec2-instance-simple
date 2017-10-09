locals {
  subnet_ids           = ["${split(",", var.network_configuration["subnet_ids"])}"]
  security_group_ids   = ["${split(",", var.security_configuration["security_group_ids"])}"]
  iam_instance_profile = "${lookup(var.security_configuration, "iam_instance_profile", "")}"
  enable_public        = "${lookup(var.network_configuration, "enable_public", "false")}"
}

resource "aws_instance" "simple" {
  count         = "${var.count}"
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"

  associate_public_ip_address = "${local.enable_public}"
  subnet_id                   = "${element(local.subnet_ids, count.index % length(local.subnet_ids))}"
  vpc_security_group_ids      = ["${local.security_group_ids}"]
  iam_instance_profile        = "${local.iam_instance_profile}"

  tags = "${merge(
      var.tags,
      map(
        "Name", format("%s-%d", var.name_prefix, count.index + 1)
      )
    )}"
}
