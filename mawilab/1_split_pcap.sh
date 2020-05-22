#!/bin/bash

#
# Usage: 
#		./splitPcap.sh input_file.pcap packets_per_file
#
#		It will split input_file.pcap in multiple output_files according to the specified number of 
#		packets_per_file
#
# Example of input_file:
#		http://mawi.wide.ad.jp/mawi/samplepoint-F/2019/201911211400.pcap.gz
#

editcap -c $2 $1 output.pcap
