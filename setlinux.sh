#!/bin/bash
echo Downloading Required package
clear
cd $HOME
sudo apt-get update -y && sudo apt upgrade -y
clear
sudo apt-get install git clang build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm -y
clear
echo Downloading Godot Source
git clone https://github.com/godotengine/godot.git
cd godot/thirdparty/oidn/common
wget https://raw.githubusercontent.com/DLTcollab/sse2neon/master/sse2neon.h
rm -rf platform.h
wget https://raw.githubusercontent.com/raj-extremegamerz/godot-arm-builder/master/thirdparty/oidn/common/platform.h
clear
echo Starting Building
cd ~/godot
scons platform=linuxbsd arch=arm64 tools=yes target=release_debug use_llvm=no -j8 ; scons -c # 8 threads used because most SBCs have between 4-8 cores. This will make sure they are all used for building.
scons platform=linuxbsd arch=arm64 tools=no target=release use_llvm=no -j8 ; scons -c
scons platform=linuxbsd arch=arm64 tools=no target=release_debug use_llvm=no -j8 ; scons -c
echo Build Finished
ls -a 
exit 0
