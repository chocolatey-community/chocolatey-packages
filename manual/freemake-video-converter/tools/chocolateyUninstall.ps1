$path = Get-AppInstallLocation 'Freemake Video Converter'
$fullPath = "${path}\Uninstall\unins000.exe"

$packageArgs = @{
  packageName = 'freemake-video-converter'
  fileType    = 'exe'
  silentArgs  = '/VERYSILENT /NORESTART'
  file        = $fullPath
}

Uninstall-ChocolateyPackage @packageArgs
