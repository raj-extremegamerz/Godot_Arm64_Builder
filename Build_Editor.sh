#!/bin/bash
echo Downloading Required package
cd $HOME
sudo apt-get update -y && sudo apt upgrade -y
sudo apt-get install binutils git clang build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm -y
clear
echo Downloading Godot Source
git clone https://github.com/godotengine/godot.git
cd ~/godot/thirdparty/oidn/common
wget https://raw.githubusercontent.com/DLTcollab/sse2neon/master/sse2neon.h
sudo rm -rf platform.h
wget https://raw.githubusercontent.com/raj-extremegamerz/godot-arm-builder/master/thirdparty/oidn/common/platform.h
clear
echo Starting Building
cd ~/godot
scons platform=linuxbsd arch=arm64 tools=no target=release_debug use_llvm=no -j8 ; scons -c
strip ~/godot/bin/*debug.arm64
echo Build Finished
ls -a 
ls -a bin/
exit 0
