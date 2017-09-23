# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/f1fbac85edfe6ace114f8ad50023739b2494bb31/icons/gpg4win.png" width="48" height="48"/> [gpg4win-vanilla](https://chocolatey.org/packages/gpg4win-vanilla)

Gpg4win-vanilla (GNU Privacy Guard for Windows) only installs the actual file encryption and digital signature command-line tool gpg.exe.

Gpg4win enables users to securely transport emails and files with the help of encryption and digital signatures. Encryption protects the contents against an unwanted party reading it. Digital signatures allow authors of files to sign them prior to distribution so a user may verify the file has not been tampered with and comes from a specific sender.

Gpg4win supports both relevant cryptography standards, [OpenPGP](http://www.ietf.org/rfc/rfc4880.txt) and Secure Multipurpose Internet Mail Extensions (S/MIME) X.509 certificates, and is the official GnuPG distribution for Windows.

It is maintained by the developers of GnuPG. Gpg4win and the software included with Gpg4win are Free Software (Open Source; among other things free of charge for all commercial and non-commercial purposes).

## Features

* Supports OpenPGP and S/MIME
* High algorithmic strength of GnuPG
* SmartCards for OpenPGP and S/MIME
* Sign single files or complete folders directly from the Windows Explorer with GpgEX or Kleopatra
* Create and verify checksums of files directly from the Windows Explorer or Kleopatra
* Outlook email plugin
* User-friendly Certificate Selection and management
* Import and export of certificates from and to (OpenPGP and X.509) certificate servers

More information:

* [Features](http://www.gpg4win.org/features.html)
* [Screenshots](http://www.gpg4win.org/screenshots.html)
* [Privacy policy](http://www.gpg4win.org/privacy-policy.html)
* Community: [Forum](http://wald.intevation.org/forum/forum.php?forum_id=21), [IRC](irc://irc.freenode.net/#gpg4win)

## Notes

Gpg4win is distributed in three editions and available by the following chocolatey packages:

### [gpg4win-vanilla](https://chocolatey.org/packages/gpg4win-vanilla)

* [GnuPG](https://www.gnupg.org/faq/gnupg-faq.html#general)
The backend (command-line interface); this is the actual encryption and digital signature tool used by the other software in the suite.

### [gpg4win-light](https://chocolatey.org/packages/gpg4win-ligth)

Includes all the above, and:

* [GNU Privacy Assistant (GPA)](https://www.gnupg.org/related_software/gpa/index.html)
An alternative program for managing OpenPGP and X.509 (S/MIME) certificates.
* [GnuPG for Outlook (GpgOL)](http://git.gnupg.org/cgi-bin/gitweb.cgi?p=gpgol.git;a=summary)
A plugin for the 32bit versions of Microsoft Outlook 2003/2007/2010/2013 (email encryption). For Outlook 2010/2013 GpgpOL supports the Exchange Server, but does not support MIME.
* [GPG Explorer eXtension (GpgEX)](http://git.gnupg.org/cgi-bin/gitweb.cgi?p=gpgex.git;a=summary)
A plugin for Microsoft Windows File Explorer to sign and encrypt messages using the context menu.
* [Claws Mail](http://www.claws-mail.org/)
A complete email application that offers good support for GnuPG. Also available as its own chocolatey package [claws-mail](https://chocolatey.org/packages/claws-mail).

### [gpg4win](https://chocolatey.org/packages/gpg4win)

Includes all the above, and:

* [Kleopatra](https://www.kde.org/applications/utilities/kleopatra/)
The central certiï¬cate administration of Gpg4win, which ensures uniform user navigation for all cryptographic operations.
* [Compendium](http://www.gpg4win.org/doc/en/gpg4win-compendium.html)
The documentation for beginner and advanced users, available in English and German.

