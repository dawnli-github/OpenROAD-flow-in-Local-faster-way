#!/bin/bash
#--------------------------------------------------------------------------- 
#             Copyright 2021 PENG CHENG LABORATORY
#--------------------------------------------------------------------------- 
# Author      : DawnLi
# Date        : 2021-05-12
# Project     : OpenROAD-Flow Way
#--------------------------------------------------------------------------- 

echo " ____                       _     _ "
echo "|  _ \  __ ___      ___ __ | |   (_)"
echo "| | | |/ _  \ \ /\ / / '_ \| |   | |"
echo "| |_| | (_| |\ V  V /| | | | |___| |"
echo "|____/ \__,_| \_/\_/ |_| |_|_____|_|"
sleep 1

# Function
THREAD_NUM=$(cat /proc/cpuinfo | grep "processor" | wc -l)
Dawnli_ROOT=$(cd "$(dirname "$0")" && pwd)
Dawnli_ws=$(cd "$(dirname "$0")" && pwd)/workspace
Dawnli_dl=$(cd "$(dirname "$0")" && pwd)/download
Dawnli_lmdl=$(cd "$(dirname "$0")" && pwd)/download/lemon-1.3.1/build
function CHECK_DIR()
{
    if [ -d $* ] && [ $( ls $* | wc -l ) -gt 0 ]; then
        echo "[Dawnli Info] dir exist and not empty: '$*' skiping..." && return 0
    else
        rm -rf $*
        return 1
    fi
}

function RUN()
{
    echo "[Dawnli Info] exec command: '$*' ..."
    while [ 0 -eq 0 ]
    do
        $* 
        if [ $? -eq 0 ]; then
            echo "[Dawnli Info] exec command successful: '$*' "
            break;
        else
            echo "[Dawnli Warning] exec command failed: '$*' retry..." && sleep 1
        fi
    done
}
# Env Setting
RUN cd $Dawnli_ROOT
mkdir $Dawnli_ws
mkdir $Dawnli_dl
# RUN sudo apt-get update
# RUN sudo apt-get upgrade -y
# Build Pre-Tool
RUN sudo apt-get install build-essential
RUN sudo apt install tcl-dev -y
RUN sudo cp /usr/include/tcl8.6/*.h /usr/include/
# If you have graphic interface
# RUN sudo apt install klayout
RUN sudo ln -s /usr/lib/x86_64-linux-gnu/libtcl8.6.so /usr/lib/x86_64-linux-gnu/libtcl8.5.so
RUN sudo apt install libreadline6-dev bison flex libffi-dev cmake libboost-all-dev swig libspdlog-dev libeigen3-dev -y
# Build Lemon
RUN cd $Dawnli_dl
RUN wget http://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz
RUN sudo tar zxvf lemon-1.3.1.tar.gz
RUN sudo rm -rf lemon-1.3.1.tar.gz
RUN cd $Dawnli_dl/lemon-1.3.1
mkdir $Dawnli_lmdl
RUN cd $Dawnli_lmdl && cmake .. && make -j 64 && sudo make install
# Build OpenROAD-Flow
RUN cd $Dawnli_ws
RUN sudo apt install git -y
RUN sudo git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts.git
RUN cd $Dawnli_ws/OpenROAD-flow-scripts/
RUN sudo bash $Dawnli_ws/OpenROAD-flow-scripts/build_openroad.sh --local