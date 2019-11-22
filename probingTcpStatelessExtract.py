import pyshark
import dataAnalysis

targetAttribute = ""


def retrieveattribute(packet):
    pkt_to_list = []

    # List of the attributes to be retrieved from each packet
    attributes = [
        ["ip", "version"],
        ["ip", "len"],
        ["ip", "id"],
        ["ip", "ttl"],
        ["ip", "frag_offset"],
        ["ip", "flags.rb"],
        ["ip", "flags.df"],
        ["ip", "flags.mf"],
        ["ip", "proto"],
        ["ip", "checksum"],
        ["tcp", "seq"],
        ["tcp", "ack"],
        ["tcp", "flags.fin"],
        ["tcp", "flags.syn"],
        ["tcp", "flags.reset"],
        ["tcp", "flags.push"],
        ["tcp", "flags.ack"],
        ["tcp", "flags.urg"],
        ["tcp", "options.mss_val"]  # TCP SYN - SYN/ACK
    ]

    columns = []
    for i in attributes:
        columns.append(i[0]+"."+i[1])
    columns.append("Class")

    global df
    df = dataAnalysis.setdataframecolumns(df, columns)


    for i in attributes:
        # try-except used for packet attribute validation, if not available, fill with ""
        try:
            pkt_to_list.append(getattr(getattr(packet, i[0]), i[1]))
        except:
            pkt_to_list.append("")
        global targetAttribute

    pkt_to_list.append(targetAttribute)
    dataAnalysis.appenddatatodataframe(df, pkt_to_list)
    print(pkt_to_list)


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
        ("192.168.181.131", "zmap_syn", "zmap_tcp.pcapng"),
        ("192.168.181.131", "mass_syn", "masscan.pcapng")
    )

    folder = "pcap"

    global df
    df = dataAnalysis.createdataframe()

    for i in dictpcapfile:
        global targetAttribute
        targetAttribute = i[1]
        cap = pyshark.FileCapture(folder + "/" + i[2], display_filter="tcp && ip.src == "+i[0])
        cap.apply_on_packets(retrieveattribute)
        cap.close()

    print(df.head())
    print(df.tail())
    print(df['Class'].value_counts())

if __name__ == "__main__":
    main()

