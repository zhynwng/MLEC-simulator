#!/usr/bin/bash

source ~/.bashrc
export PATH="/home/$USER/anaconda3/bin:$PATH"

echo "1. Installing Conda"
echo "==================================="
echo

if [ "$(which conda)" != "" ]
then
    echo "Anaconda has already installed."
else
    echo -e "Anaconda has not installed, installing one."
    cd /tmp
    echo "Downloading Anaconda3-2023.03-1-Linux-x86_64.sh"
    wget -q https://repo.anaconda.com/archive/Anaconda3-2023.03-1-Linux-x86_64.sh > /dev/null
    bash Anaconda3-2023.03-1-Linux-x86_64.sh -b
    echo "Anaconda installed."
    echo "export PATH=\"/home/$USER/anaconda3/bin:$PATH\"" >> ~/.bashrc
    export PATH="/home/$USER/anaconda3/bin:$PATH"
    source ~/.bashrc
fi


echo "2. Using conda to install \"numpy matplotlib mpmath pandas\""
echo "==================================="
echo

conda install -y numpy matplotlib mpmath pandas


echo "3. Downloading mlec-sim from github"
echo "==================================="
echo

git clone https://github.com/ucare-uchicago/mlec-sim.git ~/mlec-sim

echo
echo "Successfully setup mlec-sim!"

echo
echo "4. Downloading isa-l to evaluate encoding throughput"

git clone --recurse-submodules -j8 https://github.com/mengwanguc/ReedSolomonEC.git ~/ReedSolomonEC
cd ~/ReedSolomonEC/isa-l/

sudo apt update
sudo apt install gcc g++ make nasm autoconf libtool
sudo apt-get install yasm nasm

echo "Configuring isa-l... "

./autogen.sh > /dev/null
./configure > /dev/null
make -j 8 &> /dev/null
sudo make install &> /dev/null

echo "Compiling EC performance evaluation scripts..."

make perfs &> /dev/null

echo
echo "Successfully setup isa-l!"