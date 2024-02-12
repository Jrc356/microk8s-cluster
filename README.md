# Creating a multinode kubernetes cluster with Unraid and Microk8s

## What is Unraid

### My Unraid Server

## What is MicroK8s

## Glossary

This guide will not go into depth about the various Unraid terms, however, I have included a laymans glossary below (including some links to additional resources) that should allow you to understand this guide even if you're not using unraid

### **Unraid Share**

basically a folder. Read more [here](https://docs.unraid.net/unraid-os/manual/shares/).

## Creating the Cluster Nodes

1. [Download ubuntu server iso](https://ubuntu.com/download/server) and copy it to an Unraid share
2. Create 3 VMs
   1. Unraid Steps:
      1. Go to `VMs`
      2. Click `Create`
      3. Fill out the form to your liking ensuring that you select the downloaded Ubuntu Server iso as the `OS Install ISO`
      4. I will be making mine 2 virtual cpus, 2 GB of memory, and 30GB of disk [^1]
      5. XMLs found in the [unraid-vm-xml dir](./unraid-vm-xml/)
      6. Install Ubuntu Server
         1. ensure OpenSSH is installed
         2. do not install other add ons, this will be done with ansible
         3. I will be making my vm's have static ips of 10.0.0.203, 10.0.0.204, and 10.0.0.205
            1. during installation
            2. network prompt
            3. edit the network interface by selecting it and then selecting `Edit IPv4`
            4. change `Automatic (DHCP)` to `Manual`
            5. set fill out the configuration for the network you'd like to use. I will be using the following:
               1. subnet: 10.0.0.0/24
               2. address: 10.0.0.203 or 10.0.0.204 or 10.0.0.205
               3. gateway: 10.0.0.1
               4. name servers: 8.8.8.8, 1.1.1.1
      7. Stop VMs, unmount installation disks, restart vms

## Setup SSH

1. generate host keys if not already - `ssh-keygen -t rsa`
2. copy your public key to each node - `ssh-copy-id <user>@<ip>`

## Ansible

Now that we have some VM's, we need to configure them. We'll use ansible for this.

0. install ansible
1. create an inventory
2. create a playbook
3. run the playbook
4. ...
5. profit

## Kubectl Setup

I was a bit too lazy to figure out a nice way of doing this with ansible... maybe I'll come back to that. So instead I did the following:

1. ssh into a node - `ssh microk8s@10.0.0.203`
2. run `microk8s config > kubeconfig.yml`
3. copy to my local machine: `scp microk8s@10.0.0.203:/home/microk8s/kubeconfig.yml kubeconfig.yml`
4. then nitpicked the sections I needed into my existing kubeconfig

[^1]: From a quick search, I found [this issue](https://github.com/canonical/microk8s/issues/319) mentioning that the minimum specs for a microk8s node seems to be 1 CPU, 1 GB Memory, and 3 GB of storage. My numbers were chosen on a whim :sparkles:
