# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@c9f08adeb0cc2dcda323211894358e69d3af323c/icons/virtualbox.png" width="48" height="48"/> [virtualbox](https://chocolatey.org/packages/virtualbox)

VirtualBox is a cross-platform virtualization application. It installs on existing Intel or AMD-based computers, whether they are running Windows, Mac, Linux or Solaris operating systems. It extends the capabilities of your existing computer so that it can run multiple operating systems (inside multiple virtual machines) at the same time.

## Features

- Supports 64 bit versions of Windows, Mac OSX, Linux and Solaris
- Portability
- No hardware virtualization required
- Guest Additions: shared folders, seamless windows, 3D virtualization
- Great hardware support: SMP, USB devices, ACPI, multiscreen, ISCSI, PXE network boot
- Multigeneration branched snapshots
- VM groups
- Clean architecture and unprecedented modularity
- Remote machine display

## Package parameters

- `/CurrentUser`       - Install for current user only
- `/NoDesktopShortcut` - Do not create desktop shortcut
- `/NoQuickLaunch`     - Do not create quick launch icon
- `/NoRegister`        - Do not register virtualbox file extensions
- `/NoPath`            - Do not add virtualbox install directory to the PATH
- `/KeepExtensions`    - Do not uninstall installed virtualbox extensions (only when uninstalling package)
- `/ExtensionPack`     - Install extension pack - **THIS IS COMMERCIAL EXTENSION AND CAN INCURE [SIGNIFICANT COSTS](https://web.archive.org/web/20171201035409/https://www.virtualbox.org/wiki/Licensing_FAQ)**

Example: `choco install virtualbox --params "/NoDesktopShortcut /ExtensionPack"`


![screenshot](https://github.com/chocolatey-community/chocolatey-coreteampackages/blob/master/automatic/virtualbox/screenshot.png?raw=true)
