$packageName = '{{PackageName}}'
$installerType = 'EXE'
$url64 = 'http://sourceforge.net/projects/djv/files/djv-stable/{{PackageVersion}}/djv-{{PackageVersion}}-Windows-64.exe/download'

# v1.0.5 is the latest version for 32 bit OSes
$url = 'http://sourceforge.net/projects/djv/files/djv-stable/1.0.5/djv-1.0.5-Windows-32.exe/download'

$silentArgs = '/S' # NSIS package
$validExitCodes = @(0)

if (Get-ProcessorBits 32) {
  Write-Output $("You’re using a 32 bit OS. " +
    "DJV v1.0.5 is the latest version available for 32 bit OSes."
  )
}

Install-ChocolateyPackage "$packageName" "$installerType" `
  "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes
