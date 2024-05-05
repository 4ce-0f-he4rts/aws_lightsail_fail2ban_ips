output "terminal_message_0_fail2ban_explaination" {
  value = "When attackers attempt to log in using 'ssh root@${aws_lightsail_static_ip.this.ip_address}' or 'ssh ${var.remote_user}@${aws_lightsail_static_ip.this.ip_address}' they are prompted for password authentication. However, we have configured SSH key-based authentication. In the event that attackers fail to authenticate, Fail2ban will analyze the authentication logs and detect repeated failed login attempts. Upon reaching a predefined threshold, Fail2ban will dynamically update the server's firewall rules to block traffic from the attacker's IP address for a specified period of time. This proactive response helps to mitigate the risk of unauthorized access and strengthens the security of our server."
}
output "terminal_message_1_ssh_server_static_public_ip" {
  value = "LOGIN: ssh ${var.remote_user}@${aws_lightsail_static_ip.this.ip_address} -i ${var.private_key_filename}"
}
output "terminal_message_2_enable_tor" {
  value = "TEST FAIL2BAN: sudo systemctl enable tor && systemctl start tor && start anonsurf"
}
output "terminal_message_3_verify_proxychains_connection" {
  value = "TEST FAIL2BAN: proxychains ssh ${var.remote_user}@${aws_lightsail_static_ip.this.ip_address}"
}
output "terminal_message_4_verify_hydra_connection" {
  value = "TEST FAIL2BAN: hydra -l ${var.remote_user} -P /usr/share/metasploit-framework/data/wordlists/root_userpass.txt ssh://${aws_lightsail_static_ip.this.ip_address} -I -v"
}
output "terminal_message_5_use_proxychins_and_hydra_together" {
  value = "TEST FAIL2BAN: proxychains hydra -l ${var.remote_user} -P /usr/share/metasploit-framework/data/wordlists/root_userpass.txt ssh://${aws_lightsail_static_ip.this.ip_address} -I -v"
}
output "terminal_message_6_" {
  value = "cat /var/log/fail2ban.log & sudo fail2ban-client status sshd & cat ~/blacklist_ip_table/blacklist_ip_table.txt"
}
##################################################

output "terminal_message_A_path_module" {
  value = "path_module: ${path.module}"
}
output "terminal_message_B_path_root" {
  value = "path_root: ${path.root}"
}
output "terminal_message_C_path_cwd" {
  value = "path_cwd: ${path.cwd}"
}
