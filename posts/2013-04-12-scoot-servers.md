---
title: Scoot Architecture Part 1 - Servers
author: Henri
---

This is part 1 in a series detailing the systems and application architecture
running [Scoot](http://scoot.io). The core services are on Amazon Web
Services (AWS). This article describes how the Elastic Computing Cloud (EC2)
servers are built and configured.

#### Operating System

We wanted an Amazon Machine Image (AMI) that was well tailored for
virtualization on EC2, and that limits the choices. We went with Ubuntu 12.04
because of the long term service (LTS), because we are familiar with it and the
[performance](http://www.phoronix.com/scan.php?page=article&item=amazon_ec2_nov12&num=1)
looked good. There's nothing wrong with the Amazon images. They might even be
safer choices from a technical perspective but we chose the familiar.

#### Topology

Reduced to the most basic elements the topology is a familiar one.

![](/images/scoot-basic-arch.png)

Web and application services are scaled out, database services are primarily
scaled up. There are many other services in place such as a failover database
server and third party services but those will be detailed in a later post. This
just illustrates the core.

#### Builds

Servers are built with [Cloud Init](https://help.ubuntu.com/community/CloudInit),
a fancy name for running a script. An example script might look like this:

```
#!/bin/bash
set -e

## SSH authorized keys
echo ssh-rsa <snip> > /home/ubuntu/.ssh/authorized_keys

## Software installation
apt-get update
apt-get install build-essential nginx git unattended-upgrades -y

## More stuff...
## Clean up...

shutdown -r now
```

The scripts are great for a number of reasons, including:

- They serve as readable documentation of how you want the environment
  to look.
- They can be managed with a version control system.
- They are lightweight and portable. A script for an EC2 image can usually be
  run on Linode or Rackspace with little to no adjustment.

Managing server definitions with scripts is easier than managing state with
volume snapshots/images. We take volume snapshots into Elastic Block Store
(EBS) but that is in order to speed auto-scaling, not to preserve server state.

#### Configuration Management

If you have a large installation there are benefits to using a configuration
management tool. The downside is that you may spend a lot of time choosing
between [Chef](http://www.opscode.com/chef/) and
[Puppet](https://puppetlabs.com/). To me that feels like not knowing much about
photography and trying to choose between Canon and Nikon. You'll think you're
making an educated decision but in the end you'll realize the things you thought
mattered don't. Personally, I like the third horse,
[Salt](http://docs.saltstack.com/). I also  use [Ansible](http://ansible.cc/) a
good deal. Learning Ansible is a safe investment as it can be used in conjuction
with one of the other three.

#### Security

If you can manage a Virtual Private Cloud (VPC), do. A VPC takes machines that
don't need to be on the Internet off the Internet. Your database server doesn't
need to be on the Internet. Configuring a VPC is well documented.  If a VPC is
too much to manage here are basic guidelines to make use of EC2's Security
Groups:

- Make one security group for each role within your environment - one for
  database servers, one for web servers, one for load balancers, etc.
- Configure your groups to allow traffic only from the appropriate groups. For
  example, don't let your database talk to your web servers and don't let your
  load balancer talk to your database.
- Let the Internet (0.0.0.0/0) talk to your load balancer.
- Don't let the Internet talk to your web servers or your database.
- Don't let the Internet SSH/RDP to your instances. Whitelist your remoting.
  Need to work from home on a startup? Figure out your home IP and allow that.
  Nothing more.

Do not get comfy here. Do not trade too much security for convenience.

#### Security, bis

I like to use the unattended-upgrades package to install [automatic security
updates](https://help.ubuntu.com/community/AutomaticSecurityUpdates).  This
favors security over application stability. Do it this way until it bites you
too many times.

If you use Ubuntu subscribe to the
[security announcements mailing list](https://lists.ubuntu.com/mailman/listinfo/ubuntu-security-announce).
If you use another distribution, subscribe to their mailing list(s).

Patch your kernel and reboot when security fixes become available.
[Uprecords](http://podgorny.cz/moin/Uptimed) are fun but safe is better than
sorry.

#### Other Articles in the Series

[Scoot Architecture Part 2 - Application Stack](../scoot-stack/)

More articles to come...
