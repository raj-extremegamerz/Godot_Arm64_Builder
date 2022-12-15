#!/bin/bash
echo Downloading Required package
cd $HOME
sudo apt-get update -y && sudo apt upgrade -y
sudo apt-get install binutils git clang build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm -y
clear
echo Downloading Godot Source
git clone https://github.com/godotengine/godot.git
cd ~/godot/thirdparty/oidn/common
wget https://raw.githubusercontent.com/raj-extremegamerz/Godot_Arm64_Builder/main/sse2neon.h
sudo rm -rf platform.h
wget https://raw.githubusercontent.com/raj-extremegamerz/Godot_Arm64_Builder/main/platform.h
clear
echo Starting Building
cd ~/godot
scons platform=linuxbsd arch=arm64 tools=no target=editor use_llvm=no -j8
strip ~/godot/bin/*.arm64
echo Build Finished
ls -a 
ls -a bin/
exit 0
