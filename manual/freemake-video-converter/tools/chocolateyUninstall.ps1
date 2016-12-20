$uninstaller = '\Freemake\Freemake Video Converter\Uninstall\unins000.exe'
if ("${Env:ProgramFiles(x86)}") {
  $fullPath = "${Env:ProgramFiles(x86)}$uninstaller"
} else {
  $fullPath = "${Env:ProgramFiles}$uninstaller"
}

$packageArgs = @{
  packageName = 'freemake-video-converter'
  fileType    = 'exe'
  silentArgs  = '/VERYSILENT /NORESTART'
  file        = $fullPath
}

Uninstall-ChocolateyPackage @packageArgs
