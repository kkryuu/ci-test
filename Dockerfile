FROM --platform=linux/amd64 ubuntu:18.04
ENV DEBIAN_FRONTEND="noninteractive"
# How build docker by 
# command : cd platform\docker
# command sub path     : docker build --rm -f "gconsole\Dockerfile" -t kul1977/gconsole_test:1.0 "gconsole"
# command current path : docker build --rm . -t kul1977/gconsole_test:1.0

# How run docker by 
# command : docker run -it -d -v /D/Workspace/DTAC_EDW/DEV_ORI:/DEV_ORI -v /D/Workspace/DTAC_EDW/DEV:/DEV -v /D/Workspace/DTAC_EDW/DDL:/DDL kul1977/linux_test:1.0
# command : docker run -it -d --rm --name gconsole kul1977/gconsole_test:1.0

# How attach to docker by bash terminal
# command : docker exec -it gconsole bash

RUN apt-get update
RUN apt install -y default-jre
RUN apt install -y nano
RUN apt install -y dos2unix
# RUN apt install -y ucommon-utils
# RUN apt install -y wget
RUN apt install -y curl
RUN apt install -y ksh


# unix ODBC libdb4o-cil-dev
RUN apt-get install -y libssl-dev libncurses5-dev libsqlite3-dev libreadline-dev libtk8.6 libgdm-dev libpcap-dev 
RUN apt-get install -y build-essential libffi-dev
RUN apt install -y unixodbc unixodbc-dev

# install mailx
# RUN apt install -y mailutils
# RUN echo "postfix postfix/mailname string your.hostname.com" | debconf-set-selections &&\
#     echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections &&\
#     apt-get install -y mailutils

# install Python
# RUN apt install -y python3.8
# RUN apt install -y python3.8-dev
# RUN apt install -y python3.8-venv
# RUN apt install -y python3-pip
# RUN python3.8 -V
# RUN wget https://bootstrap.pypa.io/get-pip.py
# RUN python3.8 get-pip.py
# RUN ln -s /usr/bin/python3.8 /usr/local/bin/python3
# RUN rm -f /usr/local/bin/pip3
# RUN ln -s /usr/local/bin/pip /usr/local/bin/pip3

#install mysql client
# RUN apt install -y mysql-client

# install ssh
RUN apt install -y openssh-server
RUN apt install -y sshpass

# install library python
# RUN pip install pandas 

# Error when build no version again
# RUN pip install xlrd
# RUN pip install xlrd==1.2.0

# RUN pip install numpy 
# RUN pip install sqlparse
# RUN pip install sql_metadata
# RUN pip install pymysql
# RUN pip install vertica_python
# RUN pip install jenkins
# RUN pip install python-jenkins
# RUN pip install openpyxl

# Craet Unit Test
# RUN pip install Image
# RUN pip install xlsxwriter
# RUN pip install py

# RUN format number currency (1234.00 to 1,234.00)
RUN apt-get install -y locales locales-all
RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

# Set Date/Time to Asia/Bangkok
ENV TZ 'Asia/Bangkok'
# RUN rm /etc/localtime && \
#     ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
#     dpkg-reconfigure -f noninteractive tzdata && \
#     apt-get clean

RUN apt-get update
RUN apt install -y git


# install lib for DTAC
# RUN apt install -y mutt
# RUN apt install -y bsdmainutils
# RUN apt install -y bc
RUN apt install -y dumb-init
RUN apt install -y lsb-release

# setup environment for Vertica uDx
# RUN apt-get update
# RUN apt install -y gdb
# RUN apt install -y libbz2-dev
# RUN apt install -y libghc-zlib-dev
# RUN apt install -y libboost-dev
# RUN apt install -y libghc-curl-dev
# RUN apt install -y openjdk-11-jdk

# display % progress
# RUN apt install -y pv

# RUN wget -s https://www.python.org/ftp/python/3.8.15/Python-3.8.15.tgz && tar -zxvf Python-3.8.15.tgz

# RUN ./configure --prefix=/datagrid/dlprod/gconsole/python/Ubuntu18-04_python/ --libdir=/datagrid/dlprod/gconsole/python/Ubuntu18-04_python/lib --enable-optimizations

# RUN cd; echo "\n\n# Setup locale for format number currency (1234.00 to 1,234.00)" >> /root/.profile
# # RUN cd; echo "export PATH=$PATH:/usr/bin:/~/Framework" >> /root/.profile
# RUN cd; echo "export LC_ALL=en_US.UTF-8" >> /root/.profile
# RUN cd; echo "export LANG=en_US.UTF-8" >> /root/.profile
# RUN cd; echo "export LANGUAGE=en_US.UTF-8\n" >> /root/.profile
# RUN cd; echo "export PATH=$PATH:/usr/bin:/DEV/UTIL/Vertica/opt/vertica/bin" >> /root/.profile

# RUN cd; echo "\n\n# alias for developer" >> /root/.profile
# RUN cd; echo "alias TD='cd /DEV/EDW/Scripts/TD'" >> /root/.profile
# RUN cd; echo "alias CONF='cd /DEV/EDW/CONF/TD'" >> /root/.profile
# RUN cd; echo "alias JKS='cd /DEV/UTIL/Jenkins'" >> /root/.profile
# RUN cd; echo "alias FWK='cd /DEV/UTIL/FWK'" >> /root/.profile

# add new user ftp file
# ENV GROUPETL=etl
# ENV ETLFTP=aepsrv1
# RUN groupadd -g 1808 $GROUPETL
# RUN useradd -s /bin/bash -d /home/$ETLFTP -m -G $GROUPETL $ETLFTP
# RUN echo "aepsrv1\naepsrv1" | passwd aepsrv1

# Setup for Outbound Script Framework
# RUN cd; ln -s /DEV/EDW/EDW.cfg EDW.cfg

# ODBC Driver 17 for SQL Server
# require command : lsb_release
RUN curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
RUN curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | tee /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17

# optional: for bcp and sqlcmd
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
# RUN source ~/.bashrc

#Setup Folder of Gconsole
RUN mkdir -p /datagrid/dlprod/gconsole/
RUN mkdir -p /datagrid/dlprod_log/202308/raw/etl/win/
RUN mkdir -p /datagrid/dlprod/support_scripts/
RUN cd /datagrid/dlprod/gconsole/ && mkdir bin conf libs ddl logs python && mkdir -p python/Ubuntu18-04_python

# Build libraray ldd for Python 3.8.15
WORKDIR /datagrid/dlprod/gconsole/python
RUN wget https://answers.launchpad.net/ubuntu/+source/glibc/2.29-0ubuntu2/+build/16599428/+files/libc6_2.29-0ubuntu2_amd64.deb

RUN dpkg -i --auto-deconfigure --force-all libc6_2.29-0ubuntu2_amd64.deb

#Setup Profile for Gconsole
COPY bin/. /datagrid/dlprod/gconsole/bin/
COPY conf/* /datagrid/dlprod/gconsole/conf/
COPY libs/* /datagrid/dlprod/gconsole/libs/
COPY python/Ubuntu18-04_python/. /datagrid/dlprod/gconsole/python/Ubuntu18-04_python/
COPY ddl/. /datagrid/dlprod/gconsole/ddl/
COPY logs/. /datagrid/dlprod_log/202308/raw/etl/win/
COPY logs/. /datagrid/dlprod/support_scripts/
# setup path when attach docker
WORKDIR /datagrid/dlprod/gconsole/bin
RUN /datagrid/dlprod/gconsole/python/Ubuntu18-04_python/bin/python3.8 -m pip install pandas
RUN /datagrid/dlprod/gconsole/python/Ubuntu18-04_python/bin/python3.8 -m pip install numpy
RUN /datagrid/dlprod/gconsole/python/Ubuntu18-04_python/bin/python3.8 -m pip install sqlalchemy
RUN /datagrid/dlprod/gconsole/python/Ubuntu18-04_python/bin/python3.8 -m pip install cryptography
RUN /datagrid/dlprod/gconsole/python/Ubuntu18-04_python/bin/python3.8 -m pip install schedule
RUN /datagrid/dlprod/gconsole/python/Ubuntu18-04_python/bin/python3.8 -m pip install azure-storage-blob

RUN wget http://es.archive.ubuntu.com/ubuntu/pool/main/libf/libffi/libffi7_3.3-4_amd64.deb
RUN dpkg -i libffi7_3.3-4_amd64.deb



CMD ["dumb-init","bash"]

