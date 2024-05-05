resource "tls_private_key" "this" {
  algorithm   = "RSA"
  ecdsa_curve = "P224"
  rsa_bits    = 4096
}
##############################
resource "local_file" "private_key_pem" {
  filename = "${var.ssh_directory_path}/private_key_pem"
  content  = tls_private_key.this.private_key_pem
}
resource "local_file" "public_key_pem" {
  filename = "${var.ssh_directory_path}/public_key_pem"
  content  = tls_private_key.this.public_key_pem
}
resource "local_file" "private_key_openssh" {
  filename = "${var.ssh_directory_path}/private_key_openssh"
  content  = tls_private_key.this.private_key_openssh
}
resource "local_file" "public_key_openssh" {
  filename = "${var.ssh_directory_path}/public_key_openssh"
  content  = tls_private_key.this.public_key_openssh
}
resource "local_file" "private_key_pem_pkcs8" {
  filename = "${var.ssh_directory_path}/private_key_pem_pkcs8"
  content  = tls_private_key.this.private_key_pem_pkcs8
}
resource "local_file" "public_key_fingerprint_md5" {
  filename = "${var.ssh_directory_path}public_key_fingerprint_md5"
  content  = tls_private_key.this.public_key_fingerprint_md5
}
resource "local_file" "public_key_fingerprint_sha256" {
  filename = "${var.ssh_directory_path}/public_key_fingerprint_sha256"
  content  = tls_private_key.this.public_key_fingerprint_sha256
}
##################################################
# Imports Existing Public Key into Lightsail Instance
resource "aws_lightsail_key_pair" "this" {
  public_key = local_file.public_key_openssh.content
}