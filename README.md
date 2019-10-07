# Probing Dataset
Dataset of Probing Attacks (Port Scan) performed with nmap, unicornscan, hping3, zmap and masscan


|Tool	|	Method	|	Syntax	|	Source/Attacker IP	|	Destination IP	|	Target Environment	|	Target Port |
|---|---|---|---|---|---|---|
|nmap	|TCP SYN	|nmap -sS 	|192.168.181.140	|192.168.181.1	|Host VM (Windows)|N/A|	
|nmap	|UDP Scan	|nmap -sU 	|192.168.181.141	|192.168.181.1	|Host VM (Windows)|N/A|	
|nmap	|TCP Connect	|nmap -sT	|192.168.181.142	|192.168.181.1	|Host VM (Windows)|N/A|	
|nmap	|TCP NULL	|nmap -sN	|192.168.181.143	|192.168.181.1	|Host VM (Windows)|N/A|	
|nmap	|TCP XMAS	|nmap -sX	|192.168.181.144	|192.168.181.1	|Host VM (Windows)|N/A|	
|nmap	|TCP FIN	|nmap -sF	|192.168.181.145	|192.168.181.1	|Host VM (Windows)|N/A|	
|nmap	|TCP ACK	|nmap -sA	|192.168.181.146	|192.168.181.1	|Host VM (Windows)|N/A|	
|nmap	|TCP Window	|nmap -sW	|192.168.181.147	|192.168.181.1	|Host VM (Windows)|N/A|	
|nmap	|TCP Maimon	|nmap -sM	|192.168.181.148	|192.168.181.1	|Host VM (Windows)|N/A|	
|unicornscan	|TCP SYN	|unicornscan -Iv -mT	|192.168.181.150	|192.168.181.1	|Host VM (Windows)|N/A|	
|unicornscan	|UDP Scan	|unicornscan -Iv -mU	|192.168.181.151	|192.168.181.1	|Host VM (Windows)|N/A|	
|unicornscan	|TCP Connect	|unicornscan -Iv -msf	|192.168.181.152	|192.168.181.1	|Host VM (Windows)|N/A|	
|unicornscan	|TCP NULL	|unicornscan -Iv -mTs	|192.168.181.153	|192.168.181.1	|Host VM (Windows)|N/A|	
|unicornscan	|TCP XMAS	|unicornscan -Iv -mTsFPU	|192.168.181.154	|192.168.181.1	|Host VM (Windows)|N/A|	
|unicornscan	|TCP FULL XMAS	|unicornscan -Iv -mTFSRPAU	|192.168.181.155	|192.168.181.1	|Host VM (Windows)|N/A|	
|unicornscan	|TCP FIN	|unicornscan -Iv -mTsF	|192.168.181.156	|192.168.181.1	|Host VM (Windows)	|N/A|
|unicornscan	|TCP ACK	|unicornscan -Iv -mTsA	|192.168.181.157	|192.168.181.1	|Host VM (Windows)	|N/A|	
|hping3	|TCP SYN	|hping3 -c 1000 -V -p ++20 -S	|192.168.181.160	|192.168.181.1	|Host VM (Windows)	|> 20|
|hping3	|UDP Scan	|hping3 -c 1000 -V -p ++20 -2	|192.168.181.161	|192.168.181.1	|Host VM (Windows)	|> 20|
|hping3	|TCP NULL	|hping3 -c 1000 -V -p ++20 -Y	|192.168.181.162	|192.168.181.1	|Host VM (Windows)	|> 20|
|hping3	|TCP XMAS	|hping3 -c 1000 -V -p ++20 -UPF	|192.168.181.163	|192.168.181.1	|Host VM (Windows)	|> 20|
|hping3	|TCP FIN	|hping3 -c 1000 -V -p ++20 -F	|192.168.181.164	|192.168.181.1	|Host VM (Windows)	|> 20|
|hping3	|TCP ACK	|hping3 -c 1000 -V -p ++20 -A	|192.168.181.165	|192.168.181.1	|Host VM (Windows)	|> 20|
|zmap	|TCP SYN	|zmap -B 5M -p 11311 -n 100000 -o output_file.csv	|192.168.181.131	|Random	|Internet	|11311 (ROS)|
|zmap	|UDP Scan	|zmap -M udp -p 5632 --probe-args=text:ST -N 100 -f saddr,data -o -	|192.168.181.131	|Random	|Internet	|5632 (PCAnywhere)|
|masscan	|TCP SYN	|masscan -p21,22,23,80,8000 200.0.0.0/8 --rate=10000	|192.168.181.131	|200.0.0.0/8	|Internet	|21, 22, 23, 80, 8000|
