# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@15cb498f3d11b3687c99e98d077031ad85a62c96/icons/win10mct.png" width="48" height="48"/> [win10mct](https://chocolatey.org/packages/win10mct)

This will allow you to Create Windows 10 installation media
To get started, you will first need to have a license to install Windows 10.
You can then download and run the media creation tool. For more information on how to use the tool, see the instructions below.

## Features
- Using the tool to upgrade this PC to Windows 10 (click to show more or less information)
- Using the tool to create installation media (USB flash drive, DVD, or ISO file) to install Windows 10 on a different PC
- Using the media creation tool to re-install Windows 10 Pro for Workstations
- More download options or information can be found at https://www.microsoft.com/en-us/software-download/windows10

## Notes
- Does not support Windows 10 Enterprise.

## Package Parameters
The following package parameters can be set:

 * `/StartShortcut` - Add a start menu shortcut
 * `/DesktopShortcut` - Add a desktop shortcut

Example: `choco install win10mct --params "/NoStartShortcut /DesktopShortcut"`