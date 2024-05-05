[AWSCLIv2 Available Commands (Lightsail)](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lightsail/index.html)

[AWS Global Infrastructure - Regions & Availability Zones](https://aws.amazon.com/about-aws/global-infrastructure/regions_az/)

[Regions and Availability Zones for Amazon Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/understanding-regions-and-availability-zones-in-amazon-lightsail.html)

```powershell
aws lightsail get-regions --include-availability-zones
```
- Selecting the nearest availability zone ensures optimal low latency for your operations.

- US East (Ohio) (us-east-2) -> #us-east-2a
- US East (N. Virginia) (us-east-1) -> #us-east-1a
- US West (Oregon) (us-west-2) -> #us-west-2a #us-west-2b #us-west-2c #us-west-2d
- Asia Pacific (Mumbai) (ap-south-1) -> #ap-south-1a
- Asia Pacific (Seoul) (ap-northeast-2) -> #ap-northeast-2a
- Asia Pacific (Singapore) (ap-southeast-1) #ap-souteast-1a
- Asia Pacific (Sydney) (ap-southeast-2) -> #ap-southeast-2a
- Asia Pacific (Tokyo) (ap-northeast-1) -> #ap-northeast-1a
- Canada (Central) (ca-central-1) -> #ca-central-1a
- EU (Frankfurt) (eu-central-1) -> #eu-central-1a
- EU (Ireland) (eu-west-1) -> #eu-west-1a
- EU (London) (eu-west-2) -> #eu-west-2a
- EU (Paris) (eu-west-3) -> #eu-west-3a
- EU (Stockholm) (eu-north-1) -> #eu-north-1a

## Pick your Linux/Unix Instance Image [blueprintId]
```powershell
aws lightsail get-blueprints --query "blueprints[?platform=='LINUX_UNIX' && contains(type, 'os')]"
```
- Amazon Linux 2023 - 2023.4.20240401.1 -> #amazon_linux_2023
- Amazon Linux 2 - 2.0.20240329.0 -> #amazon_linux_2
- Ubuntu - 22.04 LTS -> #ubuntu_22_04
- Ubuntu - 20.04 LTS -> #ubuntu_20_04
- Ubuntu - 18.04 LTS -> #ubuntu_18_04
- Debian - 12.5 -> #debian_12
- Debian - 11.9 -> #debian_11
- Debian - 10.8 -> #debian_10
- FreeBSD - 13.2 -> #freebsd_13
- openSUSE - 15.5 -> #opensuse_15
- AlmaLinux - 9.3 -> #alma_linux_9
- CentOS - CS9-20230110 -> #centos_stream_9
- CentOS - 7 2009-01 -> #centos_7_2009_01

## Pick a Lightsail Bundle
```powershell
aws lightsail get-bundles --query "sort_by(bundles[?contains(supportedPlatforms, 'LINUX_UNIX')], &price)"
```
- AWS Lightsail bundles are predefined configurations of virtual server resources with fixed prices. They make it easy to launch and manage virtual servers by providing:

- Resource Allocation: CPU, RAM, storage, and data transfer allowances.
- Simple Pricing: Fixed monthly rates for predictable costs.
- Scalability: Easy upgrades or downgrades to adjust server resources.
- Ease of Use: User-friendly interface for quick deployment without technical expertise.
- Preconfigured Software: Some bundles come with preinstalled applications or development stacks.

- $5.00 #nano_ipv6_3_0
- $3.50 #nano_3_0
- $5.00 #micro_ipv6_3_0
- $7.00 #micro_3_0
- $10.00 #small_ipv6_3_0
- $12.00 #small_3_0
- $20.00 #medium_ipv6_3_0
- $24.00 #medium_3_0
- $40.00 #large_ipv6_3_0
- $44.00 #large_3_0
- $80.00 #xlarge_ipv6_3_0
- $84.00 #xlarge_3_0
- $160.00 #2xlarge_ipv6_3_0
- $164.00 #2xlarge_3_0