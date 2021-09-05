# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/cfd84d3d546b3479bb2c5ece367867ba6e495c30/icons/rdcman.png" width="48" height="48"/> [rdcman](https://chocolatey.org/packages/rdcman)

RDCMan manages multiple remote desktop connections. It is useful for managing server labs where you need regular access to each machine such as automated checkin systems and data centers. It is similar to the built-in MMC Remote Desktops snap-in, but more flexible.

Servers are organized into named groups. You can connect or disconnect to all servers in a group with a single command. You can view all the servers in a group as a set of thumbnails, showing live action in each session. Servers can inherit their logon settings from a parent group or a credential store. Thus when you change your lab account password, you only need to change the password stored by RDCMan in one place. Passwords are stored securely by encrypting with either CryptProtectData using the (locally) logged on user's authority or an X509 certificate.

## Notes

Upgrade note: RDG files with version 2.8+ of RDCMan are not compatible with older program versions. Any legacy RDG file opened and saved with this version will be backed up as filename.old
