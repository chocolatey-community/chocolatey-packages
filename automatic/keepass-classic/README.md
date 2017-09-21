# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/keepass.svg" width="48" height="48"/> [keepass-classic](https://chocolatey.org/packages/keepass-classic)


Today you need to remember many passwords. You need a password for the Windows network logon, your e-mail account, your website's FTP password, online passwords (like website member account), etc. etc. etc. The list is endless. Also, you should use different passwords for each account. Because if you use only one password everywhere and someone gets this password you have a problem... A serious problem. The thief would have access to your e-mail account, website, etc. Unimaginable.

KeePass is a free open source password manager, which helps you to manage your passwords in a secure way. You can put all your passwords in one database, which is locked with one master key or a key file. So you only have to remember one single master password or select the key file to unlock the whole database. The databases are encrypted using the best and most secure encryption algorithms currently known (AES and Twofish).

## Features
- [Strong Security](http://keepass.info/features.html#lnksec)
- [Multiple User Keys](http://keepass.info/features.html#lnkkeys)
- [Export To TXT, HTML, XML and CSV Files](http://keepass.info/features.html#lnkexp)
- [Import From Many File Formats](http://keepass.info/features.html#lnkimp)
- [Easy Database Transfer](http://keepass.info/features.html#lnktrans)
- [Support of Password Groups](http://keepass.info/features.html#lnkgroups)
- [Time Fields and Entry Attachments](http://keepass.info/features.html#lnktimes)
- [Auto-Type, Global Auto-Type Hot Key and Drag&Drop](http://keepass.info/features.html#lnkdragdrop)
- [Intuitive and Secure Clipboard Handling](http://keepass.info/features.html#lnkclipboard)
- [Searching and Sorting](http://keepass.info/features.html#lnksearch)
- [Multi-Language Support](http://keepass.info/features.html#lnkmultilang)
- [Strong Random Password Generator](http://keepass.info/features.html#lnkrandgen)
- [Plugin Architecture](http://keepass.info/features.html#lnkplugins)
- [Open Source!](http://keepass.info/features.html#lnkopensrc)

## Parameters
- `/DisableFileAssoc` - Do not associate KeePass with the .kbd file extension
- `/DesktopIcon` - Create an icon on the Current Users Desktop
- `/QuickLaunchIcon` - Create an icon on the Current Users Quick Launch bar (only available for Windows 7)

These parameters can be passed to the installer with the use of `--params`.
For example: `--params '"/DisableFileAssoc /DesktopIcon /QuickLaunchIcon"'`

## Notes
- This is the classic version of KeePass. If you're looking for the 2.x version (also known as *KeePass Professional Edition*), install [keepass](/packages/keepass) instead.
- Looking for the source code of KeePass classic? Click the project source url and look for the file ending with `-Src.zip`

