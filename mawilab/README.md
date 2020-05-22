## Working with MAWILab Dataset

Here are the shell scripts that support the management of large PCAP files. 
In this project the challenge is to manage MAWILab dataset (~10Gb) in a PC to be used as "background" / "normal" traffic in the IDS Machine Learning applications.

The current dataset is using for normal traffic: http://www.fukuda-lab.org/mawilab/v1.1/2019/11/21/20191121.html

### Workflow:

1. Get the MAWILab dataset to generate "normal" traffic (pcap and csv rules)
2. Run 0\_extract\_filter.py to generate 2\_filter\_pcap.sh
2. Run 1\_split\_pcap.sh on original dataset
3. Filter out anomalous and suspicious packets, run 2\_filter\_pcap.sh
4. Extract random packets from filtered PCAP files, run 3\_random\_pcap.sh

The random packets will compose the dataset as the "normal" traffic.
