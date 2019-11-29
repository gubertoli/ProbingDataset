## Working with MAWILab Dataset

Here are the shell scripts that support the management of large PCAP files. 
In this project the challenge is to manage MAWILab dataset (~10Gb) in a PC to be used as "background" / "normal" traffic in the IDS Machine Learning applications.

### Workflow:

1. Get the MAWILab dataset
2. Split the original dataset (splitPcap.sh)
3. Filter out anomalous and suspicious packets (filterPcap.sh)
4. Extract random packets from filtered PCAP files (randomPcap.sh)

The random packets will compose the dataset.
