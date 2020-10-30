# Testbed for malicious packets generation on Internet

This testbed was made and tested on the host configuration
- Ubuntu Linux 18.04.4 LTS
- Docker 19.03.6

## Using/Reproducing this testbed
A cloud infrastructure must be set to reproduce this configuration (TBD).

```
$ git clone https://github.com/gubertoli/ProbingDataset.git
$ cd ProbingDataset
$ cd internet
$ sudo apt-get install vagrant virtualbox
$ vagrant up
```

## Testbed architecture



## Available scripts on /scripts folder

- *tcpscan.sh* - Shell script to perform tcp probing attacks to the target machines with ```nmap```, ```zmap```, ```masscan```, ```hping3```, and ```unicornscan```
- *targets* - list of target IPs (one per line)

