FROM kalilinux/kali-rolling

WORKDIR /root

# applicable to build
RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get clean
RUN apt-get -y install zmap masscan hping3 nmap unicornscan

COPY ./scripts/ /root

# applicable to container run
CMD ["/bin/bash"]


