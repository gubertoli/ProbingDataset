# Testbed for malicious packets generation on Internet

This testbed was made and tested on the host configuration
- Ubuntu Linux 18.04.4 LTS
- Docker 19.03.6

## Using/Reproducing this testbed
A cloud infrastructure with targets must be set to reproduce this

To operate using a Virtual Machine
```
$ git clone https://github.com/gubertoli/ProbingDataset.git
$ cd ProbingDataset
$ cd internet
$ sudo apt-get install vagrant virtualbox
$ cd attacker_vm
$ vagrant up
```

To operate using Docker
```
$ cd attacker_container
```

## Testbed architecture



## Available scripts on /targets folder

- *tcpscan.sh* - Shell script to perform tcp probing attacks to the target machines with ```nmap```, ```zmap```, ```masscan```, ```hping3```, and ```unicornscan```
- *targets* - list of target IPs (one per line)

## /server folder
This folder contain all the required information and scripts to configure the cloud infrastructure (each "honeypot"). Currently it create a UDP service to allow remote start/stop of [tcpdump](https://www.tcpdump.org). 
This approach is used to support automatic labeling of generated pcap files (a single file for each attack).

