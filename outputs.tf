output "private_ips" {
  value = "${aws_instance.simple.*.private_ip}"
}
