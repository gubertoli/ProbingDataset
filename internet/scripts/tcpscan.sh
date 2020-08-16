#!/bin/bash

# The comments below try to explain the details of this script
#
# [!] Vagrant provisioning with shell script is by default executed with privileged rights (root)
#
# [!] zmap requires to each destination port be defined by one command-line
#
# [!] To support dataset labeling, each attack will have specific source IP (applicable to attacker box)
#
#                     $ sudo ip addr del 172.16.0.2/24 dev eth1
#                     $ sudo ip addr add 172.16.0.3/24 dev eth1
#

# Remember to disable host machine firewall (in Ubuntu 'ufw disable')
# Current kalilinux/rolling version 2020.1.2 do not have zmap and unicornscan as baseline, so it is required to install
apt-get update
apt-get install zmap unicornscan -y

echo "Starting scanning: "
date

IPS='34.215.235.204 18.181.211.222 3.250.112.204 54.206.154.130'	# target IPs
hping_pckt_count="1000"	# required for hping3

attacker_interface="eth1"
router1_mac="08:00:27:19:30:05"
repeat_unicornscan="3" # normally about 300

###################################
# nmap
###################################
# -Pn (do not ping hosts first)
# -n (no DNS resolution)
# -f (fragmentation)
###################################
for IP in ${IPS}; do

	subnet="${IP}/32"	# for zmap and masscan
	IP_masscan="${IP}/32"	# target IP for masscan

	echo -n "01!NMAP_TCP_SYN" >/dev/udp/${IP}/12000	
	sleep 5
	echo "> nmap TCP SYN Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.2/24 dev $attacker_interface
	#ip addr add 172.16.0.3/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	nmap -sS -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5	

	echo -n "02!NMAP_TCP_CONNECT" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP Connect Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.3/24 dev $attacker_interface
	#ip addr add 172.16.0.4/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	nmap -sT -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "03!NMAP_TCP_NULL" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP NULL Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.4/24 dev $attacker_interface
	#ip addr add 172.16.0.5/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	nmap -sN -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "04!NMAP_TCP_XMAS" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP XMAS Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.5/24 dev $attacker_interface
	#ip addr add 172.16.0.6/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	nmap -sX -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "05!NMAP_TCP_FIN" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP FIN Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.6/24 dev $attacker_interface
	#ip addr add 172.16.0.7/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	nmap -sF -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "06!NMAP_TCP_ACK" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP ACK Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.7/24 dev $attacker_interface
	#ip addr add 172.16.0.8/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	nmap -sA -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "07!NMAP_TCP_WINDOW" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP Window Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.8/24 dev $attacker_interface
	#ip addr add 172.16.0.9/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	nmap -sW -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "08!NMAP_TCP_MAIMON" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP Maimon Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.9/24 dev $attacker_interface
	#ip addr add 172.16.0.10/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	nmap -sM -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	###################################
	# unicornscan
	###################################

	echo -n "09!UNIC_TCP_SYN" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP SYN Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.10/24 dev $attacker_interface
	#ip addr add 172.16.0.11/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	unicornscan -Iv -mT -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "10!UNIC_TCP_CONN" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP Connect Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.11/24 dev $attacker_interface
	#ip addr add 172.16.0.12/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	unicornscan -Iv -msf -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "11!UNIC_TCP_NULL" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP NULL Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.12/24 dev $attacker_interface
	#ip addr add 172.16.0.13/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	unicornscan -Iv -mTs -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "12!UNIC_TCP_XMAS" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP XMAS Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.13/24 dev $attacker_interface
	#ip addr add 172.16.0.14/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	unicornscan -Iv -mTsFPU -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "13!UNIC_TCP_FXMAS" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP FULL XMAS Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.14/24 dev $attacker_interface
	#ip addr add 172.16.0.15/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	unicornscan -Iv -mTFSRPAU -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "14!UNIC_TCP_FIN" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP FIN Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.15/24 dev $attacker_interface
	#ip addr add 172.16.0.16/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	unicornscan -Iv -mTsF -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "15!UNIC_TCP_ACK" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP ACK Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.16/24 dev $attacker_interface
	#ip addr add 172.16.0.17/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	unicornscan -Iv -mTsA -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	###################################
	# hping3
	###################################

	echo -n "16!HPING_TCP_SYN" >/dev/udp/${IP}/12000
	sleep 5
	echo "> hping3 TCP SYN Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.17/24 dev $attacker_interface
	#ip addr add 172.16.0.18/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	hping3 ${IP} -c $hping_pckt_count -V -p ++1 -S
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "17!HPING_TCP_NULL" >/dev/udp/${IP}/12000
	sleep 5
	echo "> hping3 TCP NULL Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.18/24 dev $attacker_interface
	#ip addr add 172.16.0.19/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	hping3 ${IP} -c $hping_pckt_count -V -p ++1 -Y
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "18!HPING_TCP_XMAS" >/dev/udp/${IP}/12000
	sleep 5
	echo "> hping3 TCP XMAS Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.19/24 dev $attacker_interface
	#ip addr add 172.16.0.20/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	hping3 ${IP} -c $hping_pckt_count -V -p ++1 -UPF
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "19!HPING_TCP_FIN" >/dev/udp/${IP}/12000
	sleep 5
	echo "> hping3 TCP FIN Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.20/24 dev $attacker_interface
	#ip addr add 172.16.0.21/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	hping3 ${IP} -c $hping_pckt_count -V -p ++1 -F
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "20!HPING_TCP_ACK" >/dev/udp/${IP}/12000
	sleep 5
	echo "> hping3 TCP ACK Scan (dst_ip: ${IP})"
	#ip addr del 172.16.0.21/24 dev $attacker_interface
	#ip addr add 172.16.0.22/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	hping3 ${IP} -c $hping_pckt_count -V -p ++1 -A
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	###################################
	# zmap
	###################################
	#  zmap available probe-modules are
	#    tcp_synscan, icmp_echoscan,
	#    icmp_echo_time, udp, ntp, upnp
	#
	# -B bandwidth
	# -p port
	# -n number of hosts
	###################################
	echo -n "21!ZMAP" >/dev/udp/${IP}/12000
	sleep 5
	echo "> zmap TCP SYN scan to network: ${subnet} "
	echo ">> zmap port /0"
	#ip addr del 172.16.0.22/24 dev $attacker_interface
	#ip addr add 172.16.0.23/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	zmap -B 1M -p 0 -n 256 --probes=250 $subnet #-i $attacker_interface #--gateway-mac=$router1_mac
	echo ">> zmap SSH port 22"
	zmap -B 1M -p 22 -n 256 --probes=250 $subnet #-i $attacker_interface #--gateway-mac=$router1_mac
	echo ">> zmap HTTP port 80"
	zmap -B 1M -p 80 -n 256 --probes=250 $subnet #-i $attacker_interface #--gateway-mac=$router1_mac
	echo ">> zmap HTTPS port 443"
	zmap -B 1M -p 443 -n 256 --probes=250 $subnet #-i $attacker_interface #--gateway-mac=$router1_mac
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	###################################
	# masscan
	###################################
	# -p port range
	###################################
	echo -n "22!MASSCAN" >/dev/udp/${IP}/12000
	sleep 5
	echo "> masscan scan to network: ${subnet}"
	#ip addr del 172.16.0.23/24 dev $attacker_interface
	#ip addr add 172.16.0.24/24 dev $attacker_interface
	#ip route add ${IP}/32 via 172.16.0.254
	masscan -p0-500 $IP_masscan #-e $attacker_interface --router-ip 172.16.0.254 # required to set interface and router ip to work in VM environment
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5
done
	
echo "> Finishing scan and returning to original interface IP"
#ip addr del 172.16.0.24/24 dev $attacker_interface
#ip addr add 172.16.0.2/24 dev $attacker_interface
#ip route add ${IP}/32 via 172.16.0.254

