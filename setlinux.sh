#!/bin/bash
echo Downloading Required package
clear
cd $HOME
sudo apt-get update -y && sudo apt upgrade -y
clear
sudo apt-get install git clang build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm -y
clear
pip3 install scons
sudo sed -i 's;#! /usr/bin/python$;#! /usr/bin/python3;' $(which scons)
sudo sed -i 's;#!/usr/bin/python$;#!/usr/bin/python3;' $(which scons)
echo Downloading Godot Source
cd
git clone https://github.com/godotengine/godot.git
cd godot
wget https://raw.githubusercontent.com/DLTcollab/sse2neon/master/sse2neon.h
sed -i 's;^#include <xmmintrin.h>;#include "sse2neon.h" thirdparty/oidn/common/platform.h
clear
echo Starting Building
cd godot
#export PATH=$HOME/.local/opt/pyston_2.3.2/bin:$HOME/.local/bin:$PATH
#~/.local/opt/pyston/pyston_2.3.2/bin/scons platform=x11 target=release_debug tools=yes use_llvm=yes CCFLAGS="-march=armv8-a+fp+simd" arch=arm64 -j4
#scons arch=arm64 -j8 platform=x11 use_llvm=yes use_lld=yes target=release_debug tools=yes
scons platform=linuxbsd tools=yes target=release_debug use_llvm=no -j8 ; scons -c # 8 threads used because most SBCs have between 4-8 cores. This will make sure they are all used for building.
#{scons platform=linuxbsd tools=no target=release use_llvm=no && mv bin/godot.linuxbsd.opt.64 bin/linux_x11_64_release} ; scons -c
scons platform=linuxbsd tools=no target=release use_llvm=no -j8 ; scons -c
#{scons platform=linuxbsd tools=no target=release_debug use_llvm=no && mv bin/godot.linuxbsd.opt.64 bin/linux_x11_64_debug} ; scons -c
scons platform=linuxbsd tools=no target=release_debug use_llvm=no -j8 ; scons -c
echo Build Finished
ls -a 
exit 0
