# Testbed for malicious packets generation

This testbed was made and tested on the host configuration
- Ubuntu Linux 18.04.4 LTS
- Vagrant 2.2.7
- Virtualbox 6.1.6

## Using/Reproducing this testbed
A cloud infrastructure must be set to reproduce this configuration.

```
$ git clone https://github.com/gubertoli/ProbingDataset.git
$ cd ProbingDataset
$ cd internet
$ vagrant up
```

## Testbed architecture



## Available scripts on /scripts folder

The scripts on this folder are for VM provisioning. All scripts shall be set on the *Vagrantfile*

- *attacker_tcpscan.sh* - Shellscript to perform tcp probing attacks to the target machine
- *nmap_tcpscan.sh* - Shellscript to perform multiples nmap attacks to the target machine

