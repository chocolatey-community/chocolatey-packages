Git Extensions is a graphical user interface for Git that allows you to control Git without using the command line.

## Features

* Windows Explorer integration for Git
* Feature rich user interface for Git

## Notes

* This package will not uninstall silently when the application was never used (see [the #3581 issue](https://github.com/gitextensions/gitextensions/issues/3581)).

* The msi `REMOVE` parameter (inside the `chocolateyInstall.ps1` file) that is defined in `silentArgs` was obtained with the following PowerShell snippet.

    ```powershell
    (
        (
            @(
                lessmsi l -t Feature gitextensionsInstall.msi `
                    | ConvertFrom-Csv `
                    | Where-Object {$_.Level -gt 1} `
                    | ForEach-Object {$_.Feature} `
            ) + 'AddToPath'
        ) | Sort-Object -Unique
    ) -join ','
    ```

  We also do not let the installer add the GitExtensions directory to the `PATH` because it leaves too many executables and dlls available on the search `PATH`. instead we create a single shim to `gitex.cmd`.
