# **Instructions**
## **Localhost (Terraform & Ansible Orchestrator)**
1. **Clone the Repository**
```
git clone git@github.com:4ce-0f-he4rts/aws_lightsail_fail2ban_ips.git
```
2. **Modify Entries in your "1-variables.tf"**
```
variable "aws_shared_credentials_files" {
  type    = string
  default = "/home/<localhost_username>/.aws/credentials"
}
```
```
variable "ssh_directory_path" {
  type    = string
  default = "/home/<localhost_username>/.ssh/aws_lightsail_fail2ban_ips"
}
variable "private_key_filename" {
  type    = string
  default = "/home/<localhost_username>/.ssh/aws_lightsail_fail2ban_ips/private_key_openssh"
}
```
```
variable "jail_local" {
  type = object({
    sshd = object({
      mode     = string
      maxretry = string
      bantime  = string
      ignoreip = string
    })
    sshd = object({
      mode     = "normal"
      maxretry = "1"
      bantime  = "30d"
      ignoreip = "<<localhost_public_ip>"
    })
  })
}
```
3. **Initialize Terraform and Review the Resource Plan**
```
cd ~/aws_lightsail_fail2ban_ips && terraform init -reconfigure && terraform plan
```
4. **Build the AWS Infrastructure (Resource Plan)**
```
terraform apply -auto-approve
``` 
5. **Review Generated Files, Directories, and CloudC2 Setup Token**
```
tree ~/.ssh ~/aws_lightsail_fail2ban_ips ~/blacklist_ip_table /etc/fail2ban --dirsfirst
```
```
ls -la ~/.ssh ~/aws_lightsail_fail2ban_ips
```
6. **Destroy AWS Infrastructure and Associated Files and Directories**
```
terraform destroy -auto-approve && cd ~ && rm -rf ~/aws_lightsail_fail2ban_ips ~/.ssh/aws_lightsail_fail2ban_ips ~/.ssh/known_hosts ~/.ssh/known_hosts.old
```
7. **Confirm Resource Destruction**
```
ls -la ~
ls -la ~/.ssh
ls -la ~/.ssh/aws_lightsail_fail2ban_ips
```
######################################################################################################################################################
## **Attacking Machine**
8. **Initialize Tor AND/OR Anonsurf Service**
```
sudo systemctl enable tor && sudo systemctl start tor && sudo systemctl start anonsurf
```
9. **Enable Proxychains**
```
proxychains ssh ubuntu@<aws_lightsail_instance_static_public_ip>
```
10. **Ensure Fail2Ban efficacy by conducting a Hydra authentication test with a designated wordlist.**
```
hydra -l ubuntu -P /usr/share/wordlists/rockyou.txt ssh://<aws_lightsail_instance_static-public-ip> -I -v
```
11. **Verify that Proxychains rotates your public IP address in alignment with your designated proxies (/etc/proxychains.conf).** 
```
dig TXT +short o-o.myaddr.l.google.com @ns1.google.com
```
######################################################################################################################################################

## **Remote Machine**
12. **Review failed login attempts on your server, use the following commands:**
```
sudo fail2ban-client status sshd
```
```
cat /var/log/fail2ban.log
```
```
cat ~/blacklist_ip_table/blacklist_ip_table.txt
```
######################################################################################################################################################

## **Troubleshoot Ansible**
```
cat inventory.yaml
```
```
ansible-playbook playbook.yaml --syntax-check -vvv
```
```
ansible-inventory -i inventory.yaml --graph --vars -vvv
```
```
ansible-inventory -i inventory.yaml --list --vars -vvv
```
######################################################################################################################################################

## **Troubleshoot AWS Lightsail Launch Script (User Data)**
```
cat /var/log/cloud-init-output.log
```
######################################################################################################################################################