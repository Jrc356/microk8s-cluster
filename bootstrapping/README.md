# Bootstrapping a multinode kubernetes cluster with Unraid and Microk8s

My homelab runs [Unraid](https://unraid.net/) which works well as a homelab + NAS combo. For the purposes of this doc,
I'll be using it [to provision my VM's](https://docs.unraid.net/unraid-os/manual/vm-support/).

## Creating the VM's

These steps outline provisioning VM's via unraid. If you're using this as a guide and don't have Unraid, provision some
VM's with your hypervisor of choice and skip over this section. If you're using Unraid, this is what I did to prepare:

1. [Download ubuntu server iso](https://ubuntu.com/download/server) and copy it to an Unraid share
2. Create 3 (or as many as you want) VMs
   1. Unraid Steps:
      1. Go to `VMs`
      2. Click `Create`
      3. Fill out the form to your liking, ensuring that you select the downloaded Ubuntu Server iso as the `OS Install ISO`
      4. I will be making mine 2 virtual cpus, 2 GB of memory, and 30GB of disk [^1]
         1. XMLs found in the [unraid-vm-xml dir](./unraid-vm-xml/)
      5. Start a VNC session and install Ubuntu Server on each of the VM's
         1. ensure OpenSSH is installed
         2. do not install other add ons, this will be done with ansible later
         3. I will be making my vm's have static ips of `10.0.0.203`, `10.0.0.204`, and `10.0.0.205` [^2]
            1. during installation we'll reach a network prompt
            2. edit the network interface by selecting it and then selecting `Edit IPv4`
            3. change `Automatic (DHCP)` to `Manual`
            4. fill out the configuration for the network you'd like to use. I will be using the following:
               1. subnet: 10.0.0.0/24
               2. address: 10.0.0.203 or 10.0.0.204 or 10.0.0.205
               3. gateway: 10.0.0.1
               4. name servers: 8.8.8.8, 1.1.1.1
      6. Stop VMs, unmount installation disks, restart vms

## Setup SSH

Once we have our VM's created, we'll want to setup some ssh key goodness.

1. generate host keys if not already - `ssh-keygen -t rsa`
2. copy your public key to each node - `ssh-copy-id <user>@<ip>`

nice.

## Ansible

Now we need to setup these bad boys to be microk8s nodes. I'm lazy and don't want to ssh into each machine and manually
set them up... so instead let's spend more time than it would take to manually do it and automate it with
[Ansible](https://docs.ansible.com/ansible/latest/index.html). You can find the playbook I made
(mostly cut from [istvano's](https://github.com/istvano/ansible_role_microk8s) handiwork).

It's been a long while since I've tinkered with ansible... I still don't like it :)

## Kubectl Setup

I was a bit too lazy to figure out a nice way of doing this with ansible... maybe I'll come back to that. So instead I 
did the following:

1. ssh into a node - `ssh microk8s@10.0.0.203`
2. run `microk8s config > kubeconfig.yml`
3. copy to my local machine: `scp microk8s@10.0.0.203:/home/microk8s/kubeconfig.yml kubeconfig.yml`
4. then nitpicked the sections I needed into my existing kubeconfig

[^1]: From a quick search, I found [this issue](https://github.com/canonical/microk8s/issues/319) mentioning that the minimum specs for a microk8s node seems to be 1 CPU, 1 GB Memory, and 3 GB of storage. My numbers were chosen on a whim :sparkles:
[^2]: my dhcp is set so that I have a block of IPs at the tail end of the mask
