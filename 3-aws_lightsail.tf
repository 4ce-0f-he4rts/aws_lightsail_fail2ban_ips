resource "aws_lightsail_static_ip" "this" {
  name = "${var.aws_lightsail_static_ip_name}-${var.env}"
  # aws_lightsail_static_ip resource outputs: arn, id, ip_address, name, support_code
}

resource "aws_lightsail_instance" "this" {
  name              = "${var.aws_lightsail_instance.name}-${var.env}"
  availability_zone = var.aws_lightsail_instance.availability_zone
  blueprint_id      = var.aws_lightsail_instance.blueprint_id
  bundle_id         = var.aws_lightsail_instance.bundle_id
  ip_address_type   = var.aws_lightsail_instance.ip_address_type
  user_data         = "${var.aws_lightsail_instance.user_data}"
  key_pair_name     = aws_lightsail_key_pair.this.name
  add_on {
    type          = var.aws_lightsail_instance.add_on.autosnapshot.type
    snapshot_time = var.aws_lightsail_instance.add_on.autosnapshot.snapshot_time
    status        = var.aws_lightsail_instance.add_on.autosnapshot.status
  }
  /*
  aws_lightsail_instance resource outputs: arn, id, created_at. cpu_count, ram_size, 
  ipv6_addresses, public_ip_addresses, is_static_ip, username, tags_all
  */
}

resource "aws_lightsail_static_ip_attachment" "this" {
  static_ip_name = aws_lightsail_static_ip.this.id
  instance_name  = aws_lightsail_instance.this.id
  # aws_lightsail_static_ip_attachment resource ouputs: id, instance_name, ip_address, static_ip_name
}

##################################################
resource "local_file" "install_and_configure_fail2ban_sh" { # Generates jail.local configuration - Adds configurations from variables to jail.local
  filename = "${path.cwd}/include/scripts/jail.local"
  content = templatefile("${path.cwd}/include/templates/jail_local.tftpl", {
    var_jail_local_sshd_mode     = "${var.jail_local.sshd.mode}",
    var_jail_local_sshd_maxretry = "${var.jail_local.sshd.maxretry}",
    var_jail_local_sshd_bantime  = "${var.jail_local.sshd.bantime}",
    var_jail_local_sshd_ignoreip = "${var.jail_local.sshd.ignoreip}"
  })
}
resource "local_file" "ansible_inventory_yaml" { # Makes a dynamic Ansible inventory file with the static public ip assigned to the AWS Lightsail Instance
  filename = "${path.cwd}/inventory.yaml"
  content = templatefile("${path.cwd}/include/templates/inventory.tftpl", {
    static_public_ip_addrs = ["${aws_lightsail_static_ip.this.ip_address}"],
    remote_user            = "${var.remote_user}"
  })
}
resource "local_file" "setup_and_run_ansible_playbook_sh" { # MOdifyy the SSH keys to AWS' required permissions for ssh keys & Runs the Ansible PLaybook
  filename = "${path.cwd}/include/scripts/setup_and_run_ansible_playbook.sh"
  content = templatefile("${path.cwd}/include/templates/setup_and_run_ansible_playbook.tftpl", {
    var_ssh_directory_path   = "${var.ssh_directory_path}",
    var_private_key_filename = "${var.private_key_filename}"
  })
}
##################################################
resource "null_resource" "lightsail_provisioners" {

  triggers = {
    instance_id = aws_lightsail_instance.this.id
  }
  
  provisioner "remote-exec" {
    inline = ["echo 'Connecting to remote host via SSH...'"]

  connection {
    type        = "ssh"
    user        = var.remote_user
    private_key = tls_private_key.this.private_key_openssh
    host        = aws_lightsail_static_ip_attachment.this.ip_address
  }
  }

  provisioner "local-exec" {
    command = "${local_file.setup_and_run_ansible_playbook_sh.content}"
  
  connection {
    type        = "ssh"
    user        = var.remote_user
    private_key = tls_private_key.this.private_key_openssh
    host        = aws_lightsail_static_ip_attachment.this.ip_address
  }
  }
}
