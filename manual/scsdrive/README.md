# ScsDrive

ScsDrive mounts a NAS, WebDAV share or cloud storage as a real local Windows drive letter.

The mounted share shows up under "This PC" with its own drive letter, so programs that only accept
local paths can open it directly, and tools that walk the drive list see it like any other disk.

## Package Notes

- Mounting does not require administrator rights. The client has no ads and no forced subscription, and a
  7-day full-feature trial is included.
- On first launch the client installs the open-source user-mode driver Dokany (LGPL). It is a user-mode
  driver, so no kernel driver is loaded and no administrator rights are needed for that step either.
- The mount belongs to the Windows session that created it. Services and scheduled tasks that run in
  Session 0 do not see the drive letter, so programs that run as a service cannot use it.
- The client rebuilds its mounts at startup and reconnects on its own after a network drop.

## Installation

```powershell
choco install scsdrive
```

The package installs the official Inno Setup installer published with the release. If you prefer not to
install anything, the portable build from the same release works the same way after unzipping it.

## Uninstall

```powershell
choco uninstall scsdrive
```

Project site: https://drive.scsoi.com
