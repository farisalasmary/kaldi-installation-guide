#!/bin/bash -e


# Faris Abdullah Alasmary (2019/04/24)


sudo apt-get update
sudo apt-get install g++ make automake autoconf sox libtool subversion python2.7 -y
sudo apt-get install make -y
sudo apt install cmake -y

sudo apt-get install git -y


git clone https://github.com/kaldi-asr/kaldi.git

cd kaldi/tools


sudo apt-get install zlib1g-dev -y

sudo extras/install_mkl.sh


OUTPUT="$(nproc)"

make -j $OUTPUT

cd ../src

./configure

make depend -j $OUTPUT

make -j $OUTPUT

cd ../tools

sudo extras/install_irstlm.sh
