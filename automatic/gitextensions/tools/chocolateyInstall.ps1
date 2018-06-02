$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'msi'
    file           = Get-ChildItem "$env:ChocolateyPackageFolder\tools\*.msi"
    silentArgs     = '/quiet /norestart ADDDEFAULT=ALL REMOVE=AddToPath,Icons'
    validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

Install-BinFile gitex "$(Get-AppInstallLocation GitExtensions)\gitex.cmd"
