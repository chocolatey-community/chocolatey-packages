﻿# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/virtualdub.png" width="48" height="48"/> [virtualdub](https://chocolatey.org/packages/virtualdub)


VirtualDub is a video capture/processing utility for 32-bit and 64-bit Windows platforms (98/ME/NT4/2000/XP/Vista/7), licensed under the GNU General Public License (GPL).  It lacks the editing power of a general-purpose editor such as Adobe Premiere, but is streamlined for fast linear operations over video.  It has batch-processing capabilities for processing large numbers of files and can be extended with third-party video filters.  VirtualDub is mainly geared toward processing AVI files, although it can read (not write) MPEG-1 and also handle sets of BMP images.

## Features

### VirtualDub helps you get video into your computer.

If your capture device is Video for Windows compatible, then VirtualDub can capture video with it. But VirtualDub isn't your average capture program:

- Fractional frame rates. Don't settle for 29 or 30 when you want 29.97.
- Optimized disk access for more consistent hard disk usage.
- Create AVI2 (OpenDML) files to break the AVI 2GB barrier and multiple files to break the FAT32 4GB limit.
- Integrated volume meter and histogram for input level monitoring.
- Real-time downsizing, noise reduction, and field swapping.
- Verbose monitoring, including compression levels, CPU usage, and free disk space.
- Access hidden video formats your capture card may support but not have a setting for, such as 352x480.
- Keyboard and mouse shortcuts for faster operation. To capture, just hit F6.
- Clean interface layout: caption, menu bar, info panel, status bar.

### VirtualDub lets you clean up video on your computer.

There are lots of programs that let you "edit" video. And yet, they're frustratingly complex for some of the simplest tasks. VirtualDub isn't an editor application; it's a pre- and post-processor that works as a valuable companion to one:

- Reads and writes AVI2 (OpenDML) and multi-segment AVI clips.
- Integrated MPEG-1 and Motion-JPEG decoders.
- Remove and replace audio tracks without touching the video.
- Extensive video filter set, including blur, sharpen, emboss, smooth, 3x3 convolution, flip, resize rotate, brightness/contrast, levels, deinterlace, and threshold.
- Bilinear and bicubic resampling -- no blocky resizes or rotates here.
- Decompress and recompress both audio and video.
- Remove segments of a video clip and save the rest, without recompressing.
- Adjust frame rate, decimate frames, and 3:2 pulldown removal.
- Preview the results, with live audio.

You can take a captured clip, trim the ends, clean up some of the noise, convert it to the proper frame size, and write out a better one. Don't see a video filter you want?  Write your own, with the filter SDK.

### VirtualDub is fast

The author of VirtualDub is very impatient. That means his program is designed for speed, both in the interface and in the processing pipeline. Converting a compressed, 320x240 MPEG-1 file to an uncompressed, 24-bit AVI requires only these two steps in VirtualDub:

- Open video file (Ctrl-O).
- Save AVI (F7).

How fast is this operation? On a C450, 40 frames per second (1.3x real-time speed). With a little tweaking, the speed rises to 55 fps (1.8x), with the CPU hardly breaking a sweat at 40%.

