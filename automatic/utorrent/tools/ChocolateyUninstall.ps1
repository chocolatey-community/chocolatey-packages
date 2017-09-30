$arguments = @{
    packageName    = 'uTorrent'
    installerType  = 'exe'
    file           = Join-Path $env:AppData 'uTorrent\uTorrent.exe'
    silentArgs     = '/uninstall /S'
    validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

Uninstall-ChocolateyPackage @arguments
