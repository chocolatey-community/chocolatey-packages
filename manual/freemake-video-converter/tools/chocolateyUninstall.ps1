$path = Get-AppInstallLocation 'Freemake Video Converter'

$packageArgs = @{
  packageName = 'freemake-video-converter'
  fileType    = 'exe'
  silentArgs  = '/VERYSILENT /NORESTART'
  file        = "${path}\Uninstall\unins000.exe"
}

Uninstall-ChocolateyPackage @packageArgs
