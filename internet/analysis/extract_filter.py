import pandas as pd
import re

"""

    This script allows the extraction of anomalous/suspicious packets from a MAWILab dataset

    Example:
        Traffic Trace: 2019/11/21
        URL: http://www.fukuda-lab.org/mawilab/v1.1/2019/11/21/20191121.html
        Info: http://mawi.wide.ad.jp/mawi/samplepoint-F/2019/201911211400.html
        tcpdump file: http://mawi.wide.ad.jp/mawi/samplepoint-F/2019/201911211400.pcap.gz
        CSV File: http://www.fukuda-lab.org/mawilab/v1.1/2019/11/21/20191121_anomalous_suspicious.csv

    CSV Header:
        anomalyID, srcIP, srcPort, dstIP, dstPort, taxonomy, heuristic, distance, nbDetectors, label

"""

def main():
    path = "20190602_anomalous_suspicious.csv"
    df = pd.read_csv(path)

    anomalous = df.loc[(df[' nbDetectors'] == "anomalous") | (df[' nbDetectors'] == "suspicious")]
    anomalous = anomalous.fillna(0) # replace NaN by 0

    # ip.src
    # tcp.srcport
    # ip.dst
    # tcp.dstport

    #filter_rule = "not (" # this line keep just the legitim traffic
    filter_rule = "(" # this line keep just malicious/anomolous traffic
    for index, row in anomalous.iterrows():
        srcIP = row[' srcIP']
        srcPort = row[' srcPort']
        dstIP = row[' dstIP']
        dstPort = row[' dstPort']

        filter_rule += " ("
        if (srcIP != 0):
            filter_rule += " && ip.src == " + str(srcIP)
        if (srcPort != 0):
            filter_rule += " && tcp.srcport == " + str(int(srcPort))
        if (dstIP != 0):
            filter_rule += " && ip.dst == " + str(dstIP)
        if (dstPort != 0):
            filter_rule += " && tcp.dstport == " + str(int(dstPort))
        filter_rule += ") || "

    filter_rule += ")"

    # fixing filter rule
    filter_rule = re.sub(r"\((\s&&\s)","(",filter_rule)
    filter_rule = filter_rule[:len(filter_rule)-4] + ")"


    with open("filter_rule.txt", "w") as rule:
        rule.write(filter_rule)
    

if __name__ == "__main__":
    main()
