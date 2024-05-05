resource "aws_lightsail_instance_public_ports" "this" {
  instance_name = aws_lightsail_instance.this.name
  port_info {
    cidrs      = var.aws_lightsail_instance_public_ports.port_22.cidrs
    ipv6_cidrs = var.aws_lightsail_instance_public_ports.port_22.ipv6_cidrs
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
  }
}