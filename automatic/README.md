## Automatic Folder

This is where you put your Chocolatey packages that are automatically packaged up by [AU](https://chocolatey.org/packages/au) framework.

AU works with packages without automatic package tokens necessary. So you can treat the packages as normal.

Execute `update_all.ps1` in the repository root to run [AU](https://chocolatey.org/packages/au) updater with default options. 

**NOTE:** Ensure when you are creating packages for AU, you don't use `--auto` as the packaging files should be normal packages. AU doesn't need the tokens to do replacement.

