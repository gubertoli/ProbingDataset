#!/bin/bash

echo "Nome do usuario: "
 whoami
echo "IP: 172.16.0.3" 
echo "Inicio em: "
 date
echo "O script está executando do diretório:"
 pwd  
echo "pfSense IP 192.168.1.1"
echo "Victim IP 192.168.1.135"
echo "Host IP 192.168.1.136"
echo "IDS IP 192.168.1.139"

#IP Alvo do PortScan
IP="192.168.1.135"

#Lista
LIST="192.168.1.101-139"

#Rede de interesse
NET="192.168.1.0/24"

#IPs Laranjas
IPL1="192.168.1.129"
IPL2="192.168.1.130"
IPL3="192.168.1.131"

#MAC Laranja
MACL="00:0c:29:87:1f:01"

#IP Zombie 
IPZ="192.168.1.136"

#Informações cadastradas
echo "IPs (laranjas): $IPL1, $IPL2, $IPL3"
echo "Rede de interesse: $NET"


#----------------------------------------------------------------------------------------------#
echo "Descobrir servidores e dispositivos: "
nmap -sP $NET
nmap -vvv -sP $LIST
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Mais informacoes sobre um host ou lista de hosts: "
nmap -vvv $LIST
nmap -f -vvv $LIST
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Verificacao completa: "
nmap -sT $IP
nmap -f -sT $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Verificacao rapida: "
nmap -F $IP
nmap -f -F $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Verificacao de versoes: "
nmap -sV $IP
nmap -f -sV $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Reason do estado atual das portas: "
nmap --reason $IP
nmap -f --reason $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Apenas as portas abertas (possivelmente): "
nmap --open $IP
nmap -f --open $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Analisar portas mais comuns: "
nmap --top-ports 10 $IP
nmap -f --top-ports 10 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Evitar inspecao de pacotes. " 
echo "Dividir o cabeçalho TCP em diversos pacotes: "
nmap -f -vvv $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#MTU (Maximum Transmission Unit) 
#Informar tamanhos fixos de MTU, os quais devem ser multiplus de 8 (8, 16, 24, 32, etc.).
echo "Tamanhos fixados de MTU: "
nmap --mtu 24 $IP
nmap -f --mtu 24 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Falsificação de pacotes. Utilização de endereços de outros hosts (laranjas)
echo "IP falsos - aleatorios: "
nmap -D RND:5 $IP
nmap -f -D RND:5 $IP
echo "IP falsos - especificos: "
nmap -D $IPL1,$IPL2,$IPL3 $IP
nmap -f -D $IPL1,$IPL2,$IPL3 $IP
echo "IP falsos - IP de origem: "
nmap -S $IPL1 -e enp0s3 $IP
nmap -f -S $IPL1 -e enp0s3 $IP
echo "IP Zombie: "
nmap -sI $IPZ $IP
nmap -f -sI $IPZ $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Verificação com múltiplas origens (falsas)
echo "Multiplas origens falsas: "
nmap -n -D $IPL1,IPL2,IPL3 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Scan de alvo protegido por um firewall (ignorar ping)
echo "Ignorar ping: "
nmap -Pn $IP
nmap -f -Pn $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Scan de alvo protegido por um firewall (UDP ping)
echo "UDP ping: "
nmap -PU $IP
nmap -f -PU $IP
nmap -f -Pn -PU $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Scan de alvo protegido por um firewall (TCP ACK (PA) e TCP Syn (PS))
echo "TCP ACK (PA) e TCP Syn (PS): "
nmap -PS $IP
nmap -f -PS $IP
nmap -f -Pn -PS $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Scan de alvo protegido por um firewall (TTCP SYN)
echo "TTCP SYN"
nmap -sS $IP
nmap -f -sS $IP
nmap -f -Pn -sS $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Verificar protocolos suportados: "
nmap -sO $IP
nmap -f -sO $IP
nmap -f -Pn -sO $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Scan de host utilizando servicos UDP: "
nmap -sU $IP
nmap -f -sU $IP
nmap -f -Pn -sU $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#TCP Null para enganar o firewall e obter uma resposta 
echo "TCP Null: "
nmap -sN $IP
nmap -f -sN $IP
nmap -f -Pn -sN $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#TCP Fin varredura no firewall 
echo "TCP Fin: "
nmap -sF $IP
nmap -f -sF $IP
nmap -f -Pn -sF $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Verificar falhas no firewall: "
nmap -sN $IP
nmap -f -sN $IP
nmap -f -Pn -sN $IP
nmap -sF $IP
nmap -f -sF $IP
nmap -f -Pn -sF $IP
nmap -sX $IP
nmap -f -sX $IP
nmap -f -Pn -sX $IP
nmap -sA $IP  #EVADING WAF/IPS USING ACK SCAN 
nmap -f -sA› $IP
nmap -f -Pn -sA› $IP
nmap -sW $IP
nmap -f -sW $IP
nmap -f -Pn -sW $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Falsificar o endereco MAC de origem: "
nmap --spoof-mac $MACL $IP
nmap -f --spoof-mac $MACL $IP
nmap -f -Pn --spoof-mac $MACL $IP
echo "MAC de um fornecedor: "
nmap --spoof-mac 3Com $IP
nmap -f --spoof-mac 3Com $IP
nmap -f -Pn --spoof-mac 3Com $IP
nmap -sT --spoof-mac CISCO $IP -p 80 #BYPASSING FIREWALL BY SPOOFING MAC ADDRESS IN NMAP
nmap -sT -Pn --spoof-mac CISCO $IP -p 80 #BYPASSING FIREWALL BY SPOOFING MAC ADDRESS IN NMAP
echo "MAC aleatorio: " 
nmap --spoof-mac 0 $IP
nmap -f --spoof-mac 0 $IP
nmap -f -Pn --spoof-mac 0 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Falsificar a endereco porta de origem: "
nmap --source-port 80 $IP
nmap -f --source-port 80 $IP
nmap -f -Pn --source-port 80 $IP
nmap $IP -p 80 --source-port 53 #HARDCODED ORIGINATING PORTS IN FIRWALL RULES
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Anexar dados aleatorios: " #EVADING FIREWALLS BY SENDING CUSTOM SIZE PACKETS
nmap --data-length 83 $IP
nmap --data-length 44 $IP
nmap --data-length 128 $IP
nmap --data-length 32 $IP
nmap -f --data-length 83 $IP
nmap -f -Pn --data-length 64 $IP
nmap -f -Pn --data-length 0 $IP
nmap $IP -p 80 --data-length 40
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Integridade não verificada
echo "Bad Checksums: "
nmap --badsum $IP
nmap -f --badsum $IP
nmap -f -Pn --badsum $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Procurar host em ordem aleatoria: "
nmap --randomize-hosts $LIST
nmap -f --randomize-hosts $LIST
nmap -f -Pn --randomize-hosts $LIST
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "Exibe saidas instaladas e caminhos percorridos: "
nmap --iflist
nmap -f --iflist
nmap -f -Pn --iflist
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "firewall-bypass: " #https://nmap.org/nsedoc/scripts/firewall-bypass.html
nmap --script=firewall-bypass $IP
nmap -f --script=firewall-bypass $IP
nmap -f -Pn --script=firewall-bypass $IP
nmap -nmap --script=firewall-bypass --script-args firewall-bypass.helper="ftp", firewall-bypass.targetport=22 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "firewalk: " #https://nmap.org/nsedoc/scripts/firewalk.html
nmap --script=firewalk --traceroute $IP
nmap -f --script=firewalk --traceroute $IP
nmap -f -Pn --script=firewalk --traceroute $IP
nmap --script=firewalk --traceroute --script-args=firewalk.max-retries=1 $IP
nmap --script=firewalk --traceroute --script-args=firewalk.probe-timeout=400ms $IP
nmap --script=firewalk --traceroute --script-args=firewalk.max-probed-ports=7 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "http-methods: " #https://nmap.org/nsedoc/scripts/http-methods.html
nmap --script=http-methods $IP
nmap -f --script=http-methods $IP
nmap -f -Pn --script=http-methods $IP
nmap --script=http-methods --script-args http-methods.url-path='/website' $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "rpcinfo: " #https://nmap.org/nsedoc/scripts/rpcinfo.html
nmap --script=rpcinfo $IP
nmap -f --script=rpcinfo $IP
nmap -f -Pn --script=rpcinfo $IP
#mount.version, nfs.version, rpc.protocol
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "banner: " #https://nmap.org/nsedoc/scripts/banner.html
nmap -sV --script=banner $IP
nmap -f --script=banner $IP
nmap -f -Pn --script=banner $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "ajp-methods: " #https://nmap.org/nsedoc/scripts/ajp-methods.html
nmap -p 8009 $IP --script=ajp-methods
nmap -f $IP --script=ajp-methods
nmap -f -Pn $IP --script=ajp-methods
nmap $IP --script=ajp-methods
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "ms-sql-info: " #https://nmap.org/nsedoc/scripts/ms-sql-info.html
nmap -p 445 --script=ms-sql-info $IP
nmap --script=ms-sql-info $IP
nmap -f --script=ms-sql-info $IP
nmap -f -Pn --script=ms-sql-info $IP
nmap -p 1433 --script=ms-sql-info --script-args=mssql.instance-port=1433 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "http-vhosts: " #https://nmap.org/nsedoc/scripts/http-vhosts.html
nmap --script=http-vhosts -p 80,8080,443 $IP
nmap --script=http-vhosts $IP
nmap -f --script=http-vhosts $IP
nmap -f -Pn --script=http-vhosts $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "http-headers: " #https://nmap.org/nsedoc/scripts/http-headers.html
nmap -sV --script=http-headers $IP
nmap -f --script=http-headers $IP
nmap -f -Pn --script=http-headers $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "http-method-tamper: " #https://nmap.org/nsedoc/scripts/http-method-tamper.html
nmap -sV --script=http-method-tamper $IP
nmap -f --script=http-method-tamper $IP
nmap -f -Pn --script=http-method-tamper $IP
nmap -p80 --script=http-method-tamper --script-args 'http-method-tamper.paths={/protected/db.php,/protected/index.php}' $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "db2-das-info: " #https://nmap.org/nsedoc/scripts/db2-das-info.html
nmap -sV --script=db2-das-info $IP
nmap -f --script=db2-das-info $IP
nmap -f -Pn --script=db2-das-info $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "enip-info: " #https://nmap.org/nsedoc/scripts/enip-info.html
nmap --script=enip-info -sU -p 44818 $IP
nmap --script=enip-info -sU $IP
nmap --script=enip-info -f $IP
nmap --script=enip-info -f -Pn $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "smb-server-stats: " #https://nmap.org/nsedoc/scripts/smb-server-stats.html
nmap --script=smb-server-stats.nse -p445 $IP
nmap -sU -sS --script=smb-server-stats.nse -p U:137,T:139 $IP
nmap --script=smb-server-stats.nse $IP
nmap -f --script=smb-server-stats.nse $IP
nmap -f -Pn --script=smb-server-stats.nse $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "http-waf-detect: " #https://nmap.org/nsedoc/scripts/http-waf-detect.html
nmap -p80 --script http-waf-detect $IP
nmap --script http-waf-detect $IP
nmap -f --script http-waf-detect $IP
nmap -f -Pn --script http-waf-detect $IP
nmap -p80 --script http-waf-detect --script-args="http-waf-detect.aggro,http-waf-detect.uri=/testphp.vulnweb.com/artists.php" $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "http-waf-fingerprint: " #https://nmap.org/nsedoc/scripts/http-waf-fingerprint.html
nmap --script=http-waf-fingerprint $IP
nmap -f --script=http-waf-fingerprint $IP
nmap -f -Pn --script=http-waf-fingerprint $IP
nmap --script=http-waf-fingerprint --script-args http-waf-fingerprint.intensive=1 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "smb-enum-processes: " #https://nmap.org/nsedoc/scripts/smb-enum-processes.html
nmap --script=smb-enum-processes.nse $IP
nmap -f --script=smb-enum-processes.nse $IP
nmap -Pn --script=smb-enum-processes.nse $IP
nmap --script smb-enum-processes.nse -p445 $IP
nmap -sU -sS --script smb-enum-processes.nse -p U:137,T:139 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "http-affiliate-id: " #https://nmap.org/nsedoc/scripts/http-affiliate-id.html
nmap --script=http-affiliate-id.nse --script-args http-affiliate-id.url-path=/website $IP
nmap --script=http-affiliate-id.nse $IP
nmap -f --script=http-affiliate-id.nse $IP
nmap -Pn --script=http-affiliate-id.nse $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
echo "cics-info: " #https://nmap.org/nsedoc/scripts/cics-info.html
nmap --script=cics-info $IP
nmap -f --script=cics-info $IP
nmap -f -Pn --script=cics-info $IP
nmap --script=cics-info -p 23 $IP
nmap --script=cics-info --script-args cics-info.commands='logon applid(coolcics)',cics-info.user=test,cics-info.pass=test,cics-info.cemt='ZEMT',cics-info.trans=CICA -p 23 $IP
#----------------------------------------------------------------------------------------------#


#https://nmap.org/nsedoc/categories/discovery.html




