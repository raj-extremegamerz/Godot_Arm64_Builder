#!/bin/bash
echo Downloading Required package
clear
cd $HOME
sudo apt-get update -y && sudo apt upgrade -y
clear
sudo apt-get install git clang build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm -y
clear
echo Downloading Pystone for faster build
mkdir -p $HOME/.local/opt/pyston/
cd $HOME/.local/opt/pyston
wget https://github.com/pyston/pyston/releases/download/pyston_2.3.2/pyston_2.3.2_portable.tar.gz
tar -xf pyston_2.3.2_portable.tar.gz
cd pyston_2.3.2/bin/
./pyston -m pip install scons
mkdir -p ~/.local/bin/
ln -s ~/.local/opt/pyston_2.3.2/bin/scons ~/.local/bin/pyston-scons
echo Downloading Godot Source
git clone https://github.com/godotengine/godot.git
clear
echo Starting Building
cd godot
export PATH=$HOME/.local/opt/pyston_2.3.2/bin:$HOME/.local/bin:$PATH
~/.local/opt/pyston/pyston_2.3.2/bin/scons arch=aarch64 -j8 platform=x11 use_llvm=yes use_lld=yes target=release_debug tools=yes
echo Build Finished
ls -a 
exit 0
