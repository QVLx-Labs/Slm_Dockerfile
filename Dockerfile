# n3wm4n, $t@$h, r00r00     QVLx Labs

ARG IMAGENAME
FROM ubuntu:20.04

USER root

### SETUP THE SALVUM ROOT DIRECTORY PATH ########
# ARG SALVUM_ROOT=/home
ENV SALVUM_ROOT=/home

### SETUP THE TERMINAL ENVIRONMENT ##############
# ENV TERM xterm
ENV TERM xterm-256color
ENV DEBIAN_FRONTEND noninteractive

### COPY dep,tst,ext,cfg FOLDER INTO CONTAINER ##

COPY cfg /home/cfg
COPY dep /home/dep
COPY ext /home/ext
COPY lic /home/lic
COPY out /home/out
COPY tst /home/tst
COPY salvum /home/salvum

### UPDATE PACKAGE MANAGER ######################
RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends apt-utils

### APT DEPENDENCIES SETUP ######################
RUN apt-get install -y \
build-essential \
bison \
binutils-dev \
htop \
chrpath \
ruby-dev \
ruby-bundler \
binwalk \
check \
chrpath \
#clamav \
clang \
cpio \
#cppcheck \
cpuinfo \
debianutils \
diffstat \
dmidecode \
dsniff \
emacs \
flex \
gawk \
#gcc-multilib \
gcc-9-powerpc-linux-gnu \
gcc-10-powerpc64-linux-gnu \
gcc-10-mips-linux-gnu \
gcc-10-mips64-linux-gnuabi64 \
gcc-arm-none-eabi \
gcc-9-aarch64-linux-gnu \
gcc-10-riscv64-linux-gnu \
gcc-10-sparc64-linux-gnu \
gcc-avr \
#git \
#hashcat \
inxi \
iputils-ping \
iproute2 \
libbz2-dev \
libc6-i386 \
libcapstone-dev \
libdivsufsort-dev \
libevent-dev \
libfuse-dev \
libgit2-28 \
libgmp-dev \
libm17n-0 \
libmagickwand-6.q16-dev \
libncurses5 \
libnet-dev \
libnet1 \
libnetfilter-queue-dev \
libnids1.21 \
libnl-3-dev \
libnl-genl-3-dev \
libotf-dev \
libpcap-dev \
libpq-dev \
libreadline-dev \
libsdl1.2-dev \
libseccomp-dev \
libssl-dev \
libsqlite3-dev \
libegl1-mesa \
libsdl1.2-dev \
llvm \
ltrace \
lynx \
lzip \
mesa-common-dev \
net-tools \
network-manager \
nmap \
pciutils \
pkg-config \
proxychains \
pscan \
pylint3 \
python3-pip \
python3-git \
python3-jinja2 \
python3-pexpect \
python3-subunit \
qt5-default \
rpm2cpio \
#scrub \
#secure-delete \
sendip \
socat \
#spin \
#istegsnow \
tcpdump \
texinfo \
tftp \
tftpd-hpa \
tshark \
uftrace \
unzip \
usbutils \
#valgrind \
vim \
vsftpd \
#wipe \
xterm \
xxd \
xz-utils \
yasm \
#zstd \
zlib1g-dev

### RUBY GEM DEPENDENCIES #######################
RUN gem install acoc

### PYTHON PACKAGE DEPENDENCIES #################
RUN pip3 install getch
RUN pip3 install pyserial
RUN pip3 install termcolor
RUN pip3 install sunzip

### SET WORKING DIRECTORY AND EXECUTE SALVUM ####
WORKDIR $SALVUM_ROOT

### CREATE WIRESHARK GROUP ######################
RUN sudo groupadd wireshark
RUN sudo usermod -a -G wireshark root
RUN sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap
RUN sudo chgrp wireshark /usr/bin/dumpcap
RUN sudo chmod 750 /usr/bin/dumpcap

# VOLUME /home/nickdev
CMD $SALVUM_ROOT/salvum
