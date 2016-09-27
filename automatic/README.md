## Automatic Folder

This is where you put your Chocolatey packages that are automatically packaged up by either [AU](https://chocolatey.org/packages/au) or [Ketarin](https://chocolatey.org/packages/ketarin)/[ChocolateyPackageUpdater](https://chocolatey.org/packages/chocolateypackageupdater).

### Ketarin / ChocolateyPackageUpdater (chocopkgup)

You want to drop the actual Ketarin files (job file exports) in the top-level ketarin folder to keep them separate from the packages themselves.

The following packages implement this strategy of auto updates:

* 1password
* git.install

There is also an _output folder where the automatic packaging files with tokens to do token replacment and output package files with actual values in this folder. This folder is necessary for chocopkgup to do its work. You can decide whether to commit this set of folders or not. We recommend committing it as it makes it easier to do one off fixes and contributors to submit fixes for a package.

### Automatic Updater (AU)

AU works with packages without automatic package tokens necessary. So you can treat the packages as normal.

**NOTE:** Ensure when you are creating packages for AU, you don't use `--auto` as the packaging files should be normal packages. AU doesn't need the tokens to do replacement.

The following packages implement this strategy of auto updates:

* html-tidy
* nexus-oss
