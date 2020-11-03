import pyshark
pcap_file = "201906021400.pcap.gz"
cap = pyshark.FileCapture(pcap_file, display_filter="tcp")
print(cap)
print("-----------")

cap.load_packets()
packet_amount = len(cap)
print(packet_amount)

cap.close()

