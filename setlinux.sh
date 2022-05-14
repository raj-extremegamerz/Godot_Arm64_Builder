#!/bin/bash
tools=tools
editor=editor
echo Downloading Required package
cd $HOME
sudo apt-get update -y && sudo apt upgrade -y
sudo apt-get install git clang build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm -y
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
if [ $1 == $editor ]
then
   echo STARTING BUILD FOR EDITOR
   scons platform=linuxbsd arch=arm64 tools=yes target=release_debug use_llvm=no -j8 ; scons -c # 8 threads used because most SBCs have between 4-8 cores. This will make sure they are all used for building.
   echo BUILD FOR EDITOR HAS BEEN FINISHED
else
   echo STARTING BUILD FOR TOOLS
   scons platform=linuxbsd arch=arm64 tools=no target=release_debug use_llvm=no -j8 ; scons -c
   echo BUILD FOR TOOLS HAS BEEN FINISHED
fi
echo Build Finished
ls -a 
ls -a bin/
exit 0
