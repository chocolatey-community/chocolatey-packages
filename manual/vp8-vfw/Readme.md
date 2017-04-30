# [vp8-vfw](https://chocolatey.org/packages/vp8-vfw)

This is a video for windows (VFW) driver of the Google VP8 codec. The VP8 codec encodes with same or higher quality than most H.264 video encoders. Furthermore, it is completely royalty free for encoding and decoding.

Even though the Video for Windows driver framework is now several years old, several modern video editing tools still use extensively, such as Virtualdub. Sometimes, there is still a need to compress videos using standard AVI containers, therefore I decided to wrap the VP8 library around a Video For Windows driver. The version here was derived from the Xvid Video For Windows driver, and is fully functional.

## Features
- Compiled with the optimized Google VP8 library
- Includes most color space conversions supported by the Xvid codec
- Uses several threads on multi-core processors
- Encoded files can fully be decoded with FFMPEG as well as VLC
- FOURCC used is VP80