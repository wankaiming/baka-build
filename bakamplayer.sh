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

#release dlls and exe to a new directory
# 通过 ldd baka-mplayer.exe 得到依赖的dll
mkdir Baka-MPlayer_$arch
cp build/baka-mplayer.exe Baka-MPlayer_$arch
cp $PREFIX/bin/libgcc_s_seh-1.dll  \
$PREFIX/bin/libstdc++-6.dll  \
$PREFIX/bin/Qt5Core.dll  \
$PREFIX/bin/Qt5Gui.dll  \
$PREFIX/bin/Qt5Network.dll  \
$PREFIX/bin/Qt5WinExtras.dll  \
$PREFIX/bin/libzip.dll  \
$PREFIX/bin/Qt5Widgets.dll  \
$PREFIX/bin/libwinpthread-1.dll  \
$PREFIX/bin/mpv-1.dll  \
$PREFIX/bin/libharfbuzz-0.dll  \
$PREFIX/bin/libpng16-16.dll  \
$PREFIX/bin/zlib1.dll  \
$PREFIX/bin/libdouble-conversion.dll  \
$PREFIX/bin/libicuuc68.dll  \
$PREFIX/bin/libicuin68.dll  \
$PREFIX/bin/libpcre2-16-0.dll  \
$PREFIX/bin/libzstd.dll  \
$PREFIX/bin/libbz2-1.dll  \
$PREFIX/bin/liblzma-5.dll  \
$PREFIX/bin/libarchive-13.dll  \
$PREFIX/bin/libass-9.dll  \
$PREFIX/bin/avcodec-58.dll  \
$PREFIX/bin/avformat-58.dll  \
$PREFIX/bin/avfilter-7.dll  \
$PREFIX/bin/avutil-56.dll  \
$PREFIX/bin/libbluray-2.dll  \
$PREFIX/bin/avdevice-58.dll  \
$PREFIX/bin/libcaca-0.dll  \
$PREFIX/bin/libjpeg-8.dll  \
$PREFIX/bin/libiconv-2.dll  \
$PREFIX/bin/lua51.dll  \
$PREFIX/bin/libplacebo-72.dll  \
$PREFIX/bin/librubberband-2.dll  \
$PREFIX/bin/liblcms2-2.dll  \
$PREFIX/bin/libshaderc_shared.dll  \
$PREFIX/bin/swscale-5.dll  \
$PREFIX/bin/libvapoursynth-script-0.dll  \
$PREFIX/bin/swresample-3.dll  \
$PREFIX/bin/libvulkan-1.dll  \
$PREFIX/bin/libfreetype-6.dll  \
$PREFIX/bin/libzimg-2.dll  \
$PREFIX/bin/libglib-2.0-0.dll  \
$PREFIX/bin/libgraphite2.dll  \
$PREFIX/bin/libexpat-1.dll  \
$PREFIX/bin/liblz4.dll  \
$PREFIX/bin/libfribidi-0.dll  \
$PREFIX/bin/libcelt0-2.dll  \
$PREFIX/bin/libaom.dll  \
$PREFIX/bin/libdav1d.dll  \
$PREFIX/bin/libgsm.dll  \
$PREFIX/bin/libfontconfig-1.dll  \
$PREFIX/bin/libmfx-1.dll  \
$PREFIX/bin/libmp3lame-0.dll  \
$PREFIX/bin/libopencore-amrwb-0.dll  \
$PREFIX/bin/libopenjp2-7.dll  \
$PREFIX/bin/libopus-0.dll  \
$PREFIX/bin/libspeex-1.dll  \
$PREFIX/bin/libtheoradec-1.dll  \
$PREFIX/bin/libvorbis-0.dll  \
$PREFIX/bin/libvorbisenc-2.dll  \
$PREFIX/bin/libwavpack-1.dll  \
$PREFIX/bin/libvpx-1.dll  \
$PREFIX/bin/libopencore-amrnb-0.dll  \
$PREFIX/bin/libwebpmux-3.dll  \
$PREFIX/bin/libwebp-7.dll  \
$PREFIX/bin/xvidcore.dll  \
$PREFIX/bin/libgnutls-30.dll  \
$PREFIX/bin/libmodplug-1.dll  \
$PREFIX/bin/librtmp-1.dll  \
$PREFIX/bin/libsrt.dll  \
$PREFIX/bin/libxml2-2.dll  \
$PREFIX/bin/postproc-55.dll  \
$PREFIX/bin/libx264-159.dll  \
$PREFIX/bin/libopenal-1.dll  \
$PREFIX/bin/SDL2.dll  \
$PREFIX/bin/libsamplerate-0.dll  \
$PREFIX/bin/libfftw3-3.dll  \
$PREFIX/bin/libepoxy-0.dll  \
$PREFIX/bin/libSPIRV-Tools.dll  \
$PREFIX/bin/libpython3.8.dll  \
$PREFIX/bin/libintl-8.dll  \
$PREFIX/bin/libpcre-1.dll  \
$PREFIX/bin/libogg-0.dll  \
$PREFIX/bin/libgmp-10.dll  \
$PREFIX/bin/libhogweed-6.dll  \
$PREFIX/bin/libidn2-0.dll  \
$PREFIX/bin/libp11-kit-0.dll  \
$PREFIX/bin/libnettle-8.dll  \
$PREFIX/bin/libtasn1-6.dll  \
$PREFIX/bin/libcrypto-1_1-x64.dll  \
$PREFIX/bin/libffi-7.dll  \
$PREFIX/bin/libbrotlidec.dll  \
$PREFIX/bin/libbrotlicommon.dll  \
$PREFIX/bin/libtheoraenc-1.dll  \
$PREFIX/bin/libicudt68.dll  \
$PREFIX/bin/libx265.dll  \
$PREFIX/bin/libunistring-2.dll  Baka-MPlayer_$arch

# 这里补充ldd 查找不到的qt依赖 （通过windeployqt查找）
mkdir Baka-MPlayer_$arch/bearer
mkdir Baka-MPlayer_$arch/iconengines
mkdir Baka-MPlayer_$arch/imageformats
mkdir Baka-MPlayer_$arch/platforms
cp $PREFIX/share/qt5/plugins/imageformats/qgif.dll \
$PREFIX/share/qt5/plugins/imageformats/qicns.dll \
$PREFIX/share/qt5/plugins/imageformats/qico.dll \
$PREFIX/share/qt5/plugins/imageformats/qjp2.dll \
$PREFIX/share/qt5/plugins/imageformats/qjpeg.dll \
$PREFIX/share/qt5/plugins/imageformats/qsvg.dll \
$PREFIX/share/qt5/plugins/imageformats/qtga.dll \
$PREFIX/share/qt5/plugins/imageformats/qtiff.dll \
$PREFIX/share/qt5/plugins/imageformats/qwbmp.dll \
$PREFIX/share/qt5/plugins/imageformats/qwebp.dll Baka-MPlayer_$arch/imageformats
cp $PREFIX/share/qt5/plugins/bearer/qgenericbearer.dll Baka-MPlayer_$arch/bearer
cp $PREFIX/share/qt5/plugins/iconengines/qsvgicon.dll Baka-MPlayer_$arch/iconengines
cp $PREFIX/share/qt5/plugins/platforms/qwindows.dll Baka-MPlayer_$arch/platforms

# 补充其他的依赖文件
mkdir Baka-MPlayer_$arch/etc
cp -r $PREFIX/etc/fonts Baka-MPlayer_$arch/etc
cp ../mpv/fonts.conf Baka-MPlayer_$arch/etc/fonts
cp -r ../fonts Baka-MPlayer_$arch
cp -r ../mpv Baka-MPlayer_$arch
