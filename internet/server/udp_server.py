from socket import *
import subprocess

server_port = 12000
server_socket = socket(AF_INET, SOCK_DGRAM)
server_socket.bind(('', server_port))

print (">> Server running...")

while True:
    message, client_address = server_socket.recvfrom(2048)
    print(">> Received message from: ", client_address[0])

    stop = ""
    filename = message.decode('utf-8')[:2]+'.pcap'  # message parsing

    # tcpdump -i eth0 tcp -s0 -nn -w captura.pcap
    # -i    | select interface (eth0)
    # tcp   | only tcp protocol
    # -s0   | snap length to unlimited
    # -nn   | not resolve hostnames or ports
    # -w    | write to file

    p = subprocess.Popen(['sudo', 'tcpdump', '-i', 'eth0', 'tcp', 'and', 'src', str(client_address[0]), '-s0', '-nn',
                          '-w', filename], stdout=subprocess.PIPE)

    while stop != "STOP":
        msg, client_addr = server_socket.recvfrom(2048)
        stop = msg.decode('utf-8')

    p.terminate()
