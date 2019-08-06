$ErrorActionPreference = 'Stop'

Import-Module $PSScriptRoot\utils\archive-helper.psm1

$packageArgs = @{
  packageName            = 'libreoffice'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.0.7/win/x86/LibreOffice_6.0.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.0.7/win/x86_64/LibreOffice_6.0.7_Win_x64.msi'
  checksum               = 'b9ffc938b4f1305676cfaa6b7a6db205e39eb82abccd540ec1e84ca7def6a50d'
  checksum64             = '851794df64168af694edd182af019a7579744945c22465f13599efd65d730cb2'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "{0}\install.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}

if ((Get-URLStatus $packageArgs.url) -eq $true){
    #Install-ChocolateyPackage @packageArgs
    Write-Output "use default settings"

} else {
    $archiveURL = Get-ArchiveURL -softwareVersion "6.0.7" -softwareHash32 $packageArgs.checksum -softwareHash64 $packageArgs.checksum64
    
    $packageArgs.url = $archiveURL[0]
    $packageArgs.url64bit = $archiveURL[1]

    Write-Host "downloading archived version"
    
    #Install-ChocolateyPackage @packageArgs
}
