# [<img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/9de2a5aefc0c7d6facb695f0ac0017328ece49e8/icons/xpdf-utils.png" height="48" width="48" /> xpdf-utils](https://chocolatey.org/packages/xpdf-utils)

Xpdf is an open source viewer for Portable Document Format (PDF) files. (These are also sometimes also called 'Acrobat' files, from the name of Adobe's PDF software.) The Xpdf project also includes a PDF text extractor, PDF-to-PostScript converter, and various other utilities.

Xpdf runs under the X Window System on UNIX, VMS, and OS/2. The non-X components (pdftops, pdftotext, etc.) also run on Win32 systems and should run on pretty much any system with a decent C++ compiler.

Xpdf is designed to be small and efficient. It can use Type 1, TrueType, or standard X fonts.

Xpdf should work on pretty much any system which runs X11 and has Unix-like (POSIX) libraries. You'll need ANSI C++ and C compilers to compile it. If you compile it for a system not listed on the xpdf web page, please let me know. If you can't get it to compile on your system, I'll try to help.

This package is not for the Xpdf viewer itself. It only installs the Xpdf utilities:

* pdftops
* pdftotext
* pdftohtml
* pdftoppm
* pdftopng
* pdfimages
* pdfinfo
* pdffonts
* pdfdetach
