# **Prerequisites (as of: 4/30/2024)** 
## **Setup AWS Accounts**
1. Sign up for a free AWS Account (this serves as your Root account):
   - Create a robust password and enable Multi-Factor Authentication (MFA) for added security.
2. Navigate to your AWS Management Console and search for "IAM":
   - Under "Access Management," select "User Groups" to create a group named "AdministratorAccess." Assign the "AWS managed - job function" policy "AdministratorAccess" to this group.
   - Under "Users," create a new user and add them to the "AdministratorAccess" User Group. In the "Security Credentials" section, generate new access keys for "Command Line Interface (CLI)" for the new user. 
   - Ensure to securely save these credentials for future use.
3. Sign out of your Root account and sign in using your IAM role user account.
4. The purpose of this setup is to safeguard your Root user account. In case the IAM role user account is compromised, you can swiftly take action by removing the user from the "AdministratorAccess"group and revoking access keys using your Root account.

## **(Ansible Control Node) Local Host Requirements:**
- The Ansible Provisioner seamlessly integrates with Linux-based operating systems, facilitating easy installation and management. You have several options to deploy it, including utilizing Windows Subsystem for Linux (WSL), setting up a virtual machine, etc...

- Deployment Options:
   - Windows Subsystem for Linux (WSL):
   - Virtual Machine (VirtualBox, VMware, etc):
- Beyond Project Scope
   - "How do I setup and use WSL.. VirtualBox.. Git..?"

- a. This project currently only supports Linux/Unix-based OS
- b. Ansible Core Version >=2.14 required
- c. Apt-Package Manager

- **WSL Available Distros:**
| Distro                                | Description                         | Package Manager | Ansible Core Version | Ansible Community Package Release | Mission                                                                                                                                                  |
|---------------------------------------|-------------------------------------|-----------------|----------------------|-----------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| Debian                                | Debian 12 GNU/Linux "Bookworm"     | apt             | 2.14                 | 7.x                               | Focuses on stability, security, and free software principles.                                                                                             |
| Kali Linux                            | Kali Linux Rolling                 | apt             | 2.14                 | 7.x                               | Designed for penetration testing, ethical hacking, and digital forensics.                                                                                  |

## **Local Installing Packages**
Package Purpose: 
ansible                    | remote configuration & drift management
awscli                     | creating aws infrastructure
curl                       | (terraform install) data transfer 
gnupg                      | (terraform install) key management
software-properties-common | (terraform install) add external repositories to the system's package manager
wget                       | (terraform install) downloading files from the internet
proxychains                | (test fail2ban ips - locahost attack machine) Pre-installed with ParrotOS
hydra                      | (test fail2ban ips - locahost attack machine) Pre-installed with ParrotOS
wordlists                  | (test fail2ban ips - locahost attack machine) Pre-installed with ParrotOS

1. Update Your Package Manager's Index
```
sudo apt update
```
2. Check Package Versions
```
apt-cache policy ansible awscli curl git gnupg software-properties-common
```
OR
```
apt-cache madison ansible awscli curl git gnupg software-properties-common
```
...Example Output:
ansible | 7.3.0+dfsg-1 | http://deb.debian.org/debian bookworm/main amd64 Packages
awscli |   2.9.19-1 | http://deb.debian.org/debian bookworm/main amd64 Packages
curl | 8.5.0-2~bpo12+1 | http://ftp.debian.org/debian bookworm-backports/main amd64 Packages
curl | 7.88.1-10+deb12u5 | http://deb.debian.org/debian bookworm/main amd64 Packages
curl | 7.88.1-10+deb12u5 | http://security.debian.org/debian-security bookworm-security/main amd64 Packages
git | 1:2.39.2-1.1 | http://deb.debian.org/debian bookworm/main amd64 Packages
gnupg | 2.2.40-1.1 | http://deb.debian.org/debian bookworm/main amd64 Packages
software-properties-common |  0.99.30-4 | http://deb.debian.org/debian bookworm/main amd64 Packages
...
3. Install Packages
```
sudo apt install ansible awscli curl git gnupg software-properties-common wget && ansible-galaxy collection install cloud.terraform
```
4. (Optional) Install the latest software packages from their respective providers' setup executables or directly from source. 
- For this project, versions 2.14 of Ansible Core & 2.9 of the AWS CLI closely track their latest versions. 
- Note: package managers (apt, yum, dnf, zypper, etc) may lag slightly behind the latest releases due to the time needed for testing, packaging, and distribution to ensure alignment with organizational mission goals, such as: security & reliability.

5. Confirm Installation
```
dpfk -l ansible awscli curl git gnupg software-properties-common wget
```
OR
```
apt list --installed | grep -E 'ansible|awscli|curl|git|gnupg|software-properties-common|wget'
```

### **Installing Terraform (...a bit more work)**
- These instructions have been provided here for your convenience, directly sourced from the official documentation. However, as updates may occur, it's recommended to refer to the website's instructions directly to ensure accuracy and alignment with any changes.

[Hashicorp Terraform Installation (Official Documentation)](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

1. Install the HashiCorp GPG key.
```
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```
2. Verify the key's fingerprint
```
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```
3. Add the official HashiCorp repository to your system. The lsb_release -cs command finds the distribution release codename for your current system, such as buster, groovy, or sid.
```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```
4. Download the package information from HashiCorp.
```
sudo apt update
```
5. Install Terraform from the new repository.
```
sudo apt-get install terraform
```
6. Confirm Installation
```
dpkg -l terrraform
```

## **Configuring AWS CLI v2**
```
aws configure
```
...Output:
AWS Access Key ID: <AWS Access Key ID>
AWS Secret Access Key: <AWS Secret Access Key>
Default region name: <us-west-2> # Choose a region from the provided list ("aws_docs.md"), ensuring it includes support for the Lightsail service
Default output format: <skip, press Enter>
...


