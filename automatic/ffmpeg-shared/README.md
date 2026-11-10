# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@edba4a5849ff756e767cba86641bea97ff5721fe/icons/ffmpeg.svg" width="48" height="48"/> [ffmpeg-shared](https://chocolatey.org/packages/ffmpeg-shared)


FFmpeg is the leading multimedia framework, able to decode, encode, transcode, mux, demux, stream, filter and play pretty much anything that humans and machines have created. It supports the most obscure ancient formats up to the cutting edge. No matter if they were designed by some standards committee, the community or a corporation. It is also highly portable: FFmpeg compiles, runs, and passes our testing infrastructure FATE across Linux, Mac OS X, Microsoft Windows, the BSDs, Solaris, etc. under a wide variety of build environments, machine architectures, and configurations.

The FFmpeg project tries to provide the best technically possible solution for developers of applications and end users alike. To achieve this we combine the best free software options available. We slightly favor our own code to keep the dependencies on other libs low and to maximize code sharing between parts of FFmpeg. Wherever the question of "best" cannot be answered we support both options so the end user can choose.

Security is a high priority and code review is always done with security in mind. Though due to the very large amounts of code touching untrusted data security issues are unavoidable and thus we provide as quick as possible updates to our last stable releases when new security issues are found.

## Features

* The `ffmpeg`, `ffprobe` and `ffplay` command line tools, put on your PATH by Chocolatey shims.
* The shared libraries behind them as DLLs (libavcodec, libavdevice, libavfilter, libavformat, libavutil, libswresample and libswscale), together with their import libraries, so other programs can link against them.

## Notes

* This package is for the stable shared (DLL) full ffmpeg version, built for Windows by Gyan Doshi.
  For a list of libraries included, go to https://www.gyan.dev/ffmpeg/builds/#libraries
  note that the list of libraries at the URL above will give those for the most recent version and may differ slightly from this package version
* The `ffmpeg` and `ffmpeg-full` packages also provide ffmpeg.exe, ffprobe.exe and ffplay.exe, so do not install more than one of them.
* The full build includes GPL-licensed components, so the combined binaries are distributed under the GPL (version 3).
* This package installs the 64-bit build only.
