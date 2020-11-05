import pyshark
pcap_file = "output_00131_20191121021442filtered.pcap"
cap = pyshark.FileCapture(pcap_file, display_filter="tcp")
print(cap)
print("-----------")

cap.load_packets()
packet_amount = len(cap)
print(packet_amount)

cap.close()

