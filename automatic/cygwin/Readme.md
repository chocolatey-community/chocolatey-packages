# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/c8d48758cdc18d43e6c1525824720377c8b9ba24/icons/Cygwin.png" width="48" height="48"/> [Cygwin](https://chocolatey.org/packages/Cygwin)


Cygwin is a collection of tools which provide a Linux look and feel environment for Windows. Cygwin is also a DLL (cygwin1.dll) which acts as a Linux API layer providing substantial Linux API functionality.

## Package parameters

- `/InstallDir`  - Set install location
- `/DesktopIcon` - Set to true to install desktop icon
- `/Proxy`       - Set to "proxy:port". Otherwise system proxy or explicit chocolatey proxy will be used
- `/Pubkey`      - URL of extra public key file (gpg format)
- `/Site`        - Download site
- `/NoStartMenu` - Set to true to prevent installation of start menu items
- `/NoAdmin`     - Do not check for and enforce running as administrator

## Notes

- This package provides only the last version of Cygwin.
- For better functionality, it is recommended you install the [cyg-get package](/packages/cyg-get). Use the cyg-get utility to add packages to your Cygwin installation.

