# [<img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/libreoffice.svg" width="48" height="48"/> LibreOffice Still](https://chocolatey.org/packages/libreoffice-still)

LibreOffice is the free power-packed Open Source personal productivity suite for Windows, macOS and Linux, that gives you six feature-rich applications for all your document production and data processing needs.

## Package parameters
* `/NoDesktopIcon` - Don't add a desktop icon.
Example: `choco install libreoffice-streams --params "/NoDesktopIcon"`

## Notes

- This package relies on the update service provided by The Document Foundation to determine new updates. As their policy is to distribute to their website immediately and to the update service after 1 to 2 weeks, there will be a delay between a new software update and a new version release of the package.
- This package installs LibreOffice Still which is the stable version of LibreOffice that has undergone more testing (over a longer time). This version is recommended for more conservative users or for deployments in enterprise or corporate environments. If you want the latest version with the most recent bleeding-edge features, install [libreoffice-fresh](/packages/libreoffice-fresh) instead.
- For business deployments, The Document Foundation (the foundation behind the LibreOffice project) strongly recommends [support from certified partners](https://www.libreoffice.org/get-help/professional-support/) which also offer long-term support versions of LibreOffice.
- Older versions of this package are likely broken because the LibreOffice team removes the download links for older versions after each update.
- **If the package is out of date by more than 2 weeks, please check [Version History](#versionhistory) for the latest submitted version. If you have a question, please ask it in [Chocolatey Community Package Discussions](https://github.com/chocolatey-community/chocolatey-packages/discussions) or raise an issue on the [Chocolatey Community Packages Repository](https://github.com/chocolatey-community/chocolatey-packages/issues) if you have problems with the package. Disqus comments will generally not be responded to.**
