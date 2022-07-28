FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install --no-install-recommends -y -q \
        apt-utils \
        build-essential \
        ca-certificates \
        curl \
        gfortran \
        git \
        openssh-client \
        rsync \
        unzip \
        wget \
        zip \
        software-properties-common \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools
RUN apt-get update --fix-missing
RUN pip3 install --upgrade pip

###########
# SoapySDR
RUN apt-get -y install python-dev swig
#core framework and toolkits (required)
RUN add-apt-repository -y ppa:pothosware/framework
#support libraries for pothos (required)
RUN add-apt-repository -y ppa:pothosware/support
RUN apt-get update -y
RUN apt-get install -y pothos-all
#or install bindings for python3
RUN apt-get install -y python3-pothos
#install development files for python blocks
RUN apt-get install -y pothos-python-dev
RUN apt-get install -y soapysdr-tools
RUN apt-get install -y python3-soapysdr python3-numpy



RUN apt-get install -y build-essential libssl-dev cmake
RUN apt-get install -y avahi-daemon
RUN service avahi-daemon start


#lsusb -d 1df7:
#SoapySDRUtil -info

#############
# SDR PLAY
#apt install -y git cmake build-essential gqrx-sdr libsoapysdr-dev soapysdr-tools
#wget https://www.sdrplay.com/software/SDRplay_RSP_API-Linux-3.07.1.run
#chmod 755 ./SDRplay_RSP_API-Linux-3.07.1.run
#./SDRplay_RSP_API-Linux-3.07.1.run


#git clone https://github.com/pothosware/SoapySDRPlay3
#cd SoapySDRPlay3
#mkdir build
#cd build

#this step didn't worked on docker, complained of not founding libsdrplay, maybe because it didn't restarted
#cmake ..
#make 
#sudo make install

# Then I did the suggested workaround

# SoapySDRUtil --probe="driver=sdrplay"



#############
# Python dev

COPY requirements.txt /tmp/
RUN pip3 install --requirement /tmp/requirements.txt


RUN mkdir src
COPY . src/
WORKDIR src/

# Add Jupyter notebook. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
RUN pip3 install jupyter
ADD https://github.com/krallin/tini/releases/download/v0.6.0/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
EXPOSE 8888
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
