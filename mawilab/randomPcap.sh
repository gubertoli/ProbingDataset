#!/bin/bash

#
# Usage: 
#		./pcap-random.sh input-file.pcap output-file
#
# Reference: 
#		https://stackoverflow.com/questions/47067272/how-to-get-random-packets-from-a-pcap-file
#

large_number=150000
smaller_number=10000
selected_pkt_numbers=$(shuf -i 0-"$large_number" -n "$smaller_number")
for j in `seq 0 512 $smaller_number`; do
    endrange=$((j+512))
    if [ "$endrange" -gt "$smaller_number" ]; then
        endrange=$smaller_number
    fi
    # Selects numbers $j to $endrange from the generated random numbers:
    echo "$j - $endrange"
    pkt_numbers=$(echo $selected_pkt_numbers | awk -v start="$j" -v end="$endrange" '{ out=""; for (i=start+1; i<=end; i++) out=out" "$i; print out}')
    editcap -r $1 $2-$j.pcap $pkt_numbers
done
mergecap -w $2.pcap `ls $2-*.pcap`