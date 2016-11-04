# Setup

## Ketarin / ChocolateyPackageUpdater Automatic Packaging

* Review `ketarin_setup.ps1` to ensure all items are set appropriately. Uncomment/change anything you need to now.
* Run `ketarin_setup.ps1`
* Open ketarin after installing it, open the settings and import `KetarinSettings.xml`.
* Set up push for Chocolatey community feed with your API key.
* Ensure `git push` doesn't require credentials.
* Review `ops/ketarinupdate.cmd` to ensure it is good to go.

**Note**: Use `ops/ketarinupdate.cmd` or similar to schedule updates.

## Automatic Updater (AU)

* Run `au_setup.ps1`.
* Configure AU [plugins](https://github.com/majkinetor/au/wiki/Plugins).
* Configure [AppVeyor](https://github.com/majkinetor/au/wiki/AppVeyor).
* Configure [local run](https://github.com/majkinetor/au/wiki#local-run).
