variable "aws_shared_credentials_files" {
  type    = string
  default = "/home/<localhost_username>/.aws/credentials"
}
variable "aws_profile" {
  type    = string
  default = "default"
}
variable "aws_region" {
  type    = string
  default = "us-west-2"
}
variable "env" {
  type    = string
  default = "fail2ban_ips"
}
##################################################
variable "ssh_directory_path" {
  type    = string
  default = "/home/<localhost_username>/.ssh/aws_lightsail_fail2ban_ips"
}
variable "private_key_filename" {
  type    = string
  default = "/home/<localhost_username>/.ssh/aws_lightsail_fail2ban_ips/private_key_openssh"
}
##################################################
variable "remote_user" {
  type    = string
  default = "ubuntu"
}

##################################################
variable "aws_lightsail_static_ip_name" {
  type    = string
  default = "static_ip_name"
}
##############################
variable "aws_lightsail_instance" {
  type = object({
    name              = string
    availability_zone = string
    blueprint_id      = string
    bundle_id         = string
    ip_address_type   = string
    user_data         = string

    add_on = object({
      autosnapshot = object({
        type          = string
        snapshot_time = string
        status        = string
      })
    })
  })

  default = {
    name              = "instance_name"
    availability_zone = "us-west-2a" # Options: See /docs/aws_docs
    blueprint_id      = "ubuntu_22_04" # Options: Keep it to Ubuntu systems at this time
    bundle_id         = "nano_3_0" # Options: See /docs/aws_docs
    ip_address_type   = "dualstack" # Options: dualstack(ipv4 + ipv6), ipv4
    user_data         = "sudo mkdir ~/blacklist_ip_table"

    add_on = {
      autosnapshot = {
        type          = "AutoSnapshot"
        snapshot_time = "06:00"
        status        = "Disabled"
      }
    }
  }
}
##################################################
variable "aws_lightsail_instance_public_ports" {
  type = object({
    port_22 = object({
      cidrs      = list(string)
      ipv6_cidrs = list(string)
    })
  })

  default = {
    port_22 = {
      cidrs      = ["0.0.0.0/0"] # SSH access:
      ipv6_cidrs = ["::/0"]      # SSH access:
    }
  }
}
##################################################
variable "jail_local" {
  type = object({
    sshd = object({
      mode     = string
      maxretry = string
      bantime  = string
      ignoreip = string
    })
  })
  default = {
    sshd = {
      mode     = "normal"         # Mode: Determines the level of aggressiveness for blocking. Options: normal, ddos, extra, aggressive
      maxretry = "1"              # Maxretry: Number of failed login attempts before blocking the IP address
      bantime  = "30d"            # Bantime: Duration for which the IP address is blocked. Options: m (minutes), h (hours), d (days), w (weeks)
      ignoreip = "<localhost_public_ip>" # Ignore IP: List of whitelisted IP addresses separated by spaces (ignoreip = "<localhost_public_ip> <localhost_public_ip>").
      # Ensure to include your public IPv4 address if needed. Leave a space between each IP address.
    }
  }
}
##################################################
variable "aws_lightsail_instance_key_pair_name" {
  type    = string
  default = "key_pair_name"
}
variable "initialize_fail2ban_systemd_sh" {
  type    = string
  default = "/include/scripts/initialize_fail2ban_systemd.sh"
}