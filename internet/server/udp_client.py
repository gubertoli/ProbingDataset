from socket import *

servers = {
        "us-west-2" : "",
        "ap-northeast-1" : "",
        "eu-west-1" : "",
        "ap-southeast-2" : ""
        }
server_port = 12000

for server_name, server_address in servers.items():
    client_socket = socket(socket.AF_INET, socket.SOCK_DGRAM)

    message = ""
    client_socket.sendto(message, (server_address, server_port))
    print (">> Connected to ", server_name)