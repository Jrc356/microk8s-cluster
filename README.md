# Creating a multinode kubernetes cluster with Unraid and Microk8s

## What is Unraid

### My Unraid Server

## What is MicroK8s

## Glossary

This guide will not go into depth about the various Unraid terms, however, I have included a laymans glossary below (including some links to additional resources) that should allow you to understand this guide even if you're not using unraid

### **Unraid Share**

basically a folder. Read more [here](https://docs.unraid.net/unraid-os/manual/shares/).

## Creating the Cluster

1. [Download ubuntu server iso](https://ubuntu.com/download/server) and copy it to an Unraid share
2. Create 3 VMs
   1. Unraid Steps:
      1. Go to `VMs`
      2. Click `Create`
      3. Fill out the form to your liking ensuring that you select the downloaded Ubuntu Server iso as the `OS Install ISO`
      4. I will be making mine 2 virtual cpus, 2 GB of memory, and 30GB of disk [^1]
      5. XMLs found in the [unraid-vm-xml dir](./unraid-vm-xml/)
      6. Install Ubuntu Server ensuring SSH is installed and started

[^1] From a quick search, I found [this issue](https://github.com/canonical/microk8s/issues/319) mentioning that the minimum specs for a microk8s node seems to be 1 CPU, 1 GB Memory, and 3 GB of storage. My numbers were chosen on a whim :sparkles:
