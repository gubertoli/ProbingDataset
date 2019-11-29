import pyshark
import pandas as pd

df = pd.DataFrame(pd.np.empty((0, 23)))     # 23 empty columns (attributes + class)


def retrieveattribute(packet):
    pkt_to_list = []

    # List of the attributes to be retrieved from each packet
    attributes = [
        #["ip", "version"],          # Internet Protocol (IP) Version    (!) not expected to change on current dataset
        ["ip", "hdr_len"],          # IP header length
        ["ip", "len"],              # Total length
        ["ip", "dsfield"],          # Differentiated Services Field
        #["ip", "id"],               # Identification                   (!) id do not provide information for classification (qualitative)
        ["ip", "ttl"],              # Time to live
        ["ip", "frag_offset"],      # Fragment offset
        # ["ip", "flags"],            # IP flags                        (!) It is prefered to use isolated bit due to implementation
        ["ip", "flags.rb"],             # Reserved bit flag
        ["ip", "flags.df"],             # Don't fragment flag
        ["ip", "flags.mf"],             # More fragments flag
        #["ip", "proto"],            # Protocol (e.g. tcp == 6)          (!) not expected to change on current dataset
        #["ip", "checksum"],         # Header checksum                   (!) checksum do not provide information for classification (qualitative)
        ["tcp", "len"],             # TCP segment length
        ["tcp", "hdr_len"],         # Header length
        ["tcp", "seq"],             # Sequence number
        ["tcp", "ack"],             # Acknowledgment number
        ["tcp", "srcport"],         # Source port
        ["tcp", "dstport"],         # Destination port
        #["tcp", "flags"],           # Flags                            (!) It is prefered to use isolated bit due to implementation
        ["tcp", "flags.fin"],           # FIN flag
        ["tcp", "flags.syn"],           # SYN flag
        ["tcp", "flags.reset"],         # RST flag
        ["tcp", "flags.push"],          # PUSH flag
        ["tcp", "flags.ack"],           # ACK flag
        ["tcp", "flags.urg"],           # URG flag
        ["tcp", "flags.cwr"],           # Congestion Window Reduced (CWR) flags
        ["tcp", "options.mss_val"]  # Maximum Segment Size
    ]

    columns = []
    for i in attributes:
        columns.append(str(i[0])+"."+str(i[1]))
    columns.append("Class")

    global df
    df.columns = columns

    for i in attributes:
        # try-except used for packet attribute validation, if not available, fill with ""
        try:
            pkt_to_list.append(getattr(getattr(packet, i[0]), i[1]))
        except:
            pkt_to_list.append("")

    pkt_to_list.append("normal")

    df.loc[len(df)] = pkt_to_list


def main():

    pcap_normal_traffic_file = "mawilab/normal_without_ipv6.pcapng"
    cap = pyshark.FileCapture(pcap_normal_traffic_file)
    cap.apply_on_packets(retrieveattribute)
    cap.close()

    print(df.head())
    print(df['Class'].value_counts())
    df.to_csv(r'normal.csv', index=None, header=True)

if __name__ == "__main__":
    main()

