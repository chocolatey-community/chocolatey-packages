# [vcredist2008](https://chocolatey.org/packages/vcredist2008)

The Microsoft Visual C++ 2008 SP1 Redistributable Package installs runtime components of Visual C++ Libraries required to run applications developed with Visual C++ SP1 on a computer that does not have Visual C++ 2008 SP1 installed. 

This package installs runtime components of C Runtime (CRT), Standard C++, ATL, MFC, OpenMP and MSDIA libraries. For libraries that support side-by-side deployment model (CRT, SCL, ATL, MFC, OpenMP) they are installed into the native assembly cache, also called WinSxS folder, on versions of Windows operating system that support side-by-side assemblies.

## Notes

- This will install **both the 32 and 64 bit versions** on a 64 bit OS.  The 32 bit version will only be installed on a 32 bit OS.
- [Latest supported Visual C++ downloads](https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads)