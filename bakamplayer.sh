#!/bin/bash

if [[ $1 == 'x86_64' ]]; then
arch=x86_64
elif [[ $1 == 'i686' ]]; then
arch=i686
else
echo "Please specify either x86_64 or i686 architecture."
exit;
fi

if [[ $arch == 'x86_64' ]]; then
PREFIX=/mingw64
LIBGCC=libgcc_s_seh-1.dll
else
PREFIX=/mingw32
LIBGCC=libgcc_s_dw2-1.dll
fi

# get baka-mplayer
rm -rf Baka-MPlayer.$arch
git clone https://hub.fastgit.org/wankaiming/Baka-MPlayer Baka-MPlayer.$arch
cd Baka-MPlayer.$arch
git pull

# build baka-mplayer
QMAKE=$PREFIX/bin/qmake \
./configure \
CONFIG+=embed_translations \ 
lupdate=$PREFIX/bin/lupdate \
lrelease=$PREFIX/bin/lrelease
mingw32-make -j `grep -c ^processor /proc/cpuinfo`

# 通过 C:\msys64\mingw64\bin\windeployqt.exe baka-mplayer.exe 得到依赖的qt dll（自动复制）
# 通过 ‪C:\msys64\usr\bin\ldd.exe baka-mplayer.exe 得到依赖的mingw dll（需要通过命令找出所有依赖的dll，然后挑出mingw的dll，然后通过cmd命令批量复制）
# 补充其他的依赖文件 fonts文件夹、mpv文件夹、youtube-dl.exe（手动复制）