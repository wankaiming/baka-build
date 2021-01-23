Baka-MPlayer
------------
https://github.com/u8sand/Baka-MPlayer
Usages:
=======
For Windows developers looking to get started quickly, MSYS2 can be used to compile Baka-MPlayer natively on a Windows machine. The MSYS2 repositories have binary packages of mingw-w64-qt5 and mpv, so the process should only involve building Baka-MPlayer itself.

To build 64-bit version on Windows:
Installing MSYS2
----------------
1. Download an installer from https://msys2.github.io/

   It doesn't matter whether the i686 or the x86_64 version is used. Both can
   build 32-bit and 64-bit binaries when running on a 64-bit version of Windows.

2. Add ``C:\msys64\mingw64\bin`` to your ``%PATH%``. mpv will depend on several
   DLLs in this folder.

3. Start a MinGW-w64 shell (``mingw64_shell.bat``). For a 32-bit build, use
   ``mingw32_shell.bat``.
Updating MSYS2
--------------

To prevent errors during post-install, ``msys2-runtime`` and ``pacman`` must be
updated first.

```bash
# Check for updates to msys2-runtime and pacman. If there were updates, restart
# MSYS2 before continuing.
pacman -Sy --needed msys2-runtime pacman

# Update everything else
pacman -Su
```
Installing Build Dependences
----------------------
```
pacman -S  git mingw-w64-x86_64-gcc mingw-w64-x86_64-binutils mingw-w64-x86_64-make base-devel mingw-w64-x86_64-qt5 mingw-w64-x86_64-pkg-config mingw-w64-x86_64-mpv mingw-w64-x86_64-libzip mingw-w64-x86_64-jbigkit mingw-w64-x86_64-mpg123
```
The time of this process depends on the speed of your internet because qt5 is a large package.
Start Building
--------------
```
arch=x86_64
./bakamplayer.sh $arch
```
If everything succeeded without error, baka-mplayer.exe will be built under Baka-MPlayer.x86_64/build/, and you can find baka-mplayer.exe with full dlls in directory Baka-MPlayer.x86_64/Baka-MPlayer_x86_64

Static Build
============
If you want to build it staticly, you have to build a static version of mpv.


Build Static Deps of Mpv
------------------------
First install the deps of building mpv:
```
pacman -S git pkg-config python3 mingw-w64-x86_64-gcc gcc mingw-w64-x86_64-ffmpeg mingw-w64-x86_64-libjpeg-turbo mingw-w64-x86_64-lua mingw-w64-x86_64-libdvdnav mingw-w64-x86_64-mpg123 mingw-w64-x86_64-libguess
```
And run:
```
arch=x86_64
./mpv.sh $arch
```
It will show you a list of lib can't be found by ld,and you have to download the PKGBUILDs of these packages from: https://github.com/Alexpux/MINGW-packages.

And then build these packages a static version by editing their PKGBUILDS.

Most packages can build a static version by adding ```--enable-static``` or ```--enable-static --disable-static``` to the configure parameter, for some packages using cmake you have to add ```DLIBTYPE=STATIC```.

NOTE
----
```
ln -s /mingw64/lib/xvidcore.a /mingw64/lib/libxvidcore.a
ln -s /mingw64/bin/x86_64-w64-mingw32-gcc-ar.exe /mingw64/bin/x86_64-w64-mingw32-ar.exe
```

Install Qt5-static
------------------
```
pacman -S mingw-w64-x86_64-qt5-static
```
Installing Build Dependences
----------------------------
```
pacman -S mingw-w64-x86_64-pkg-config mingw-w64-x86_64-libzip
```
Build Baka-MPlayer
------------------
```
arch=x86_64
./bakamplayer-static.sh $arch
```

Dynamic compile is very smooth, but static compile throws an exception.
I have checked the Lib directory, libzip.a and libbz2.a already exist, but still throw exception, then I don't know how to handle it.

Exception log:
```
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_bzip2.c.obj):(.text+0x60): undefined reference to `BZ2_bzCompress'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_bzip2.c.obj):(.text+0xbd): undefined reference to `BZ2_bzDecompress'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_bzip2.c.obj):(.text+0x143): undefined reference to `BZ2_bzCompressEnd'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_bzip2.c.obj):(.text+0x161): undefined reference to `BZ2_bzDecompressEnd'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_bzip2.c.obj):(.text+0x1fc): undefined reference to `BZ2_bzCompressInit'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_bzip2.c.obj):(.text+0x21e): undefined reference to `BZ2_bzDecompressInit'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_xz.c.obj):(.text+0x50): undefined reference to `lzma_code'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_xz.c.obj):(.text+0xb9): undefined reference to `lzma_end'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_xz.c.obj):(.text+0xe9): undefined reference to `lzma_lzma_preset'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_xz.c.obj):(.text+0x153): undefined reference to `lzma_stream_decoder'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_xz.c.obj):(.text+0x17c): undefined reference to `lzma_stream_encoder'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_xz.c.obj):(.text+0x210): undefined reference to `lzma_alone_encoder'
C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:/msys64/mingw64/lib\libzip.a(zip_algorithm_xz.c.obj):(.text+0x248): undefined reference to `lzma_alone_decoder'
collect2.exe: error: ld returned 1 exit status
mingw32-make[1]: *** [Makefile.Release:249: build/baka-mplayer.exe] Error 1
mingw32-make[1]: Leaving directory 'C:/msys64/baka-build/Baka-MPlayer_static.x86_64'
mingw32-make: *** [Makefile:45: release] Error 2
```
