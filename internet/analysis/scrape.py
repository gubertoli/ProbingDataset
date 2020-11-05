
# main url: http://www.fukuda-lab.org/mawilab/v1.1/2020/10/29/20201029.html
# info url: http://mawi.wide.ad.jp/mawi/samplepoint-F/2020/202010291400.html
# tcpdump url: http://mawi.wide.ad.jp/mawi/samplepoint-F/2020/202010291400.pcap.gz
# labels url: http://www.fukuda-lab.org/mawilab/v1.1/2020/10/29/20201029_anomalous_suspicious.csv

import datetime
import re
import pyshark
from urllib.request import urlopen, urlretrieve
from urllib.error import HTTPError
from bs4 import BeautifulSoup
import requests

def main():
    # start date definition
    date = datetime.datetime(2019,6,1,0,0,)
    number_of_days = 2 
    base_url = "http://www.fukuda-lab.org/mawilab/v1.1/"

    for i in range(number_of_days): 
        date += datetime.timedelta(days=1)
        year = str(date.year)
        month = '{:02d}'.format(date.month)
        day = '{:02d}'.format(date.day)
        yyyymmdd = year+month+day
        day_url = base_url+year+"/"+month+"/"+day+"/"+yyyymmdd
    
        try:
            html = urlopen(day_url + ".html")
        except HTTPError as e:
            print("> Not available:", year, month, day)
            continue
    
        try:
            bsobj = BeautifulSoup(html.read(), features="html.parser")
            pcap = bsobj.find("div", {"id":"content"}).findAll("a", href=re.compile("^http:\/\/mawi\.wide\.ad\.jp\/mawi\/.+pcap"))
            info = bsobj.find("div", {"id":"content"}).findAll("a", href=re.compile("^http:\/\/mawi\.wide\.ad\.jp\/mawi\/.+html"))
            
            pcap_url = pcap[0].attrs["href"]
            label_url = day_url + "_anomalous_suspicious.csv"
            info_url = info[0].attrs["href"]
        except:
            print("BS Error!")
            continue
    
        download_csv(label_url)
        download_pcap(pcap_url)


# Return the number of packets
# capinfos -Mc 201906021400.pcap.gz | grep "Number" | tr -d " " | cut -d ":" -f 2

# Return the number of filtered packets 
# tshark -r 201906021400.pcap.gz -Y "`cat filter_rule.txt`" | wc -l

def download_pcap(url):
    local_filename = url.split('/')[-1]

    with requests.get(url, stream=True) as r:
        r.raise_for_status()
        with open(local_filename, 'wb') as f:
            for chunk in r.iter_content(chunk_size=8192):
                # If you have chunk encoded response uncomment if
                # and set chunk_size=None
                #if chunk:
                f.write(chunk)
    return local_filename

def download_csv(url):
    dst = url.split('/')[-1]
    urlretrieve(url, dst)

if __name__ == '__main__':
    main()
