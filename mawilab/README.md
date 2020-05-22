## Working with MAWILab Dataset

Here are the shell scripts that support the management of large PCAP files. 
In this project the challenge is to manage MAWILab dataset (~10Gb) in a regular PC to be used as "background" / "normal" traffic in the IDS research.

### Workflow:

1. Get the MAWILab dataset to generate "normal" traffic (pcap and csv rules)

Currently this repo is based on [MAWILab Source](http://www.fukuda-lab.org/mawilab/v1.1/2019/11/21/20191121.html)
- 201911211400.pcap.gz (compressed ~3Gb / uncompressed ~10Gb)
- 20191121\_anomalous\_suspicious.csv

2. Run 0\_extract\_filter.py to generate filter\_rule.txt (to be used by 2\_filter\_pcap.sh)
> Current script is consuming 20191121\_anomalous\_suspicious.csv

3. Run 1\_split\_pcap.sh on original dataset
> It will output the splitted files as output\_#\_input\_file.pcap

```
$ ./1_split_pcap.sh input_file.pcap number_of_packets_per_file
$ ./1_split_pcap.sh 201911211400.pcap 1000000  # resulting in 134 files of 93 Mb each
```
4. Run 2\_filter\_pcap.sh to filter out anomalous and suspicious packets
> It will output the filtered files as output\_*filtered.pcap (in our case, in average, ~45Mb each)

5. Run 3\_random\_pcap.sh to extract random packets from filtered PCAP files
> It will select random $smaller\_number packets on output\_*filtered.pcap file and save as output*filteredsmall-*.pcap file (if required edit 3\_random\_pcap.sh to set it according your needs)

6. Finally, run 4\_generate\_normal\_dataset.py to generate the "normal" traffic dataset. These random packets will compose the IDS dataset as the "normal" traffic, to be saved as ./data/normal\_dataset.csv


