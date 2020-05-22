import pyshark
import pandas as pd


df = pd.DataFrame(pd.np.empty((0, 23)))     # 23 empty columns (attributes + class)
targetAttribute = ""

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

    global targetAttribute
    pkt_to_list.append(targetAttribute)

    df.loc[len(df)] = pkt_to_list


def main():
    """
        The tuples are used to define the filter criteria (ip_addr) for extract packets data
        from pcap files and to define it class
        ( Source/Attacker IP, Class, Filename )
    """

    dictpcapfile = (
        ("192.168.181.140", "nmap_syn", "nmap.pcapng"),
        ("192.168.181.142", "nmap_connect", "nmap.pcapng"),
        ("192.168.181.143", "nmap_null", "nmap.pcapng"),
        ("192.168.181.144", "nmap_xmas", "nmap.pcapng"),
        ("192.168.181.145", "nmap_fin", "nmap.pcapng"),
        ("192.168.181.146", "nmap_ack", "nmap.pcapng"),
        ("192.168.181.147", "nmap_window", "nmap.pcapng"),
        ("192.168.181.148", "nmap_maimon", "nmap.pcapng"),
        ("192.168.181.150", "unicorn_syn", "unicornscan.pcapng"),
        ("192.168.181.152", "unicorn_connect", "unicornscan.pcapng"),
        ("192.168.181.153", "unicorn_null", "unicornscan.pcapng"),
        ("192.168.181.154", "unicorn_xmas", "unicornscan.pcapng"),
        ("192.168.181.155", "unicorn_fxmas", "unicornscan.pcapng"),
        ("192.168.181.156", "unicorn_fin", "unicornscan.pcapng"),
        ("192.168.181.157", "unicorn_ack", "unicornscan.pcapng"),
        ("192.168.181.160", "hping_syn", "hping3.pcapng"),
        ("192.168.181.162", "hping_null", "hping3.pcapng"),
        ("192.168.181.163", "hping_xmas", "hping3.pcapng"),
        ("192.168.181.164", "hping_fin", "hping3.pcapng"),
        ("192.168.181.165", "hping_ack", "hping3.pcapng"),
        ("192.168.181.131", "zmap_syn", "zmap_tcp_5k.pcapng"),
        ("192.168.181.131", "mass_syn", "masscan_5k.pcapng")
    )

    folder = "pcap"

    for i in dictpcapfile:
        global targetAttribute
        targetAttribute = i[1]
        cap = pyshark.FileCapture(folder + "/" + i[2], display_filter="tcp && ip.src == "+i[0])
        cap.apply_on_packets(retrieveattribute)
        cap.close()

    print(df.head())
    print(df['Class'].value_counts())
    df.to_csv(r'probing.csv', index=None, header=True)

if __name__ == "__main__":
    main()

