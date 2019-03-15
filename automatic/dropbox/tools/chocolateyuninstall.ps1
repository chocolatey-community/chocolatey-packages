. (Join-Path (Split-Path $MyInvocation.MyCommand.Definition -Parent) 'helpers.ps1')

$packageArgs        = @{
packageName = 'dropbox'
FileType = 'exe'
SilentArgs = '/S'
File = (getDropboxRegProps).UninstallString
ValidExitCodes = ''
IgnoredArguments = ''
}

if ($uninstallProps -and $uninstallProps.UninstallString) {
    Uninstall-ChocolateyPackage @packageArgs
}
