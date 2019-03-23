# <img src="https://cdn.jsdelivr.net/gh/chocolatey/chocolatey-coreteampackages@1698c7d42b18ac8be736b6afa75a96321c426cd0/icons/partitionmasterfree.png" width="48" height="48"/> [partitionmasterfree](https://chocolatey.org/packages/partitionmasterfree)

As Partition Magic alternative, EaseUS Partition Master Free Edition is an ALL FREE partition solution and disk management utility. It allows you to extend partition, especially for system drive, settle low disk space problem, manage disk space easily on MBR and GUID partition table (GPT) disk under 32 bit and 64 bit Windows 2000/XP/Vista/Windows 7 SP1/Windows 8. The most popular hard disk management functions are brought together with powerful data protection including: Partition Manager, Disk and Partition Copy Wizard and Partition Recovery Wizard.

## Package Uninstall Arguments

- `/UninstallAdditions` - Uninstall the 'EaseUS Todo Backup' software as well (this is bundled with the partitionmasterfree program, but not installed at the same time)

**Example**
`choco uninstall partitionmasterfree --package-parameters="/UninstallAdditions"`

## Notes

- Uninstall is not completely silent, a browser window is opened during uninstallation.
- Install is not completely silent, the application is launched after installation (we will try to close the application).
