import pandas as pd

"""

    This script allows the extraction or removal of anomalous/suspicious packets from a MAWILab dataset
    MAWILab is being used on this project as "background" traffic
    It uses as input the csv file provided by MAWILab

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
    path = "mawilab/sample.csv"
    df = pd.read_csv(path)

    anomalous  = df[df[' nbDetectors'] == "anomalous" or df[' nbDetectors'] == "suspicious"]

    print(df.columns)
    print(anomalous.head())
    print(anomalous.tail())


if __name__ == "__main__":
    main()