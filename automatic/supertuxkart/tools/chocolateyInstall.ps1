$packageName = '{{PackageName}}'
$url = 'http://sourceforge.net/projects/supertuxkart/files/SuperTuxKart/{{PackageVersion}}/supertuxkart-{{PackageVersion}}.exe/download'
$silentArgs = '/S'

# Create the package temp folder if it doesn’t already exist
$tempDir = "$env:TEMP\chocolatey\$packageName"
if (!(Test-Path $tempDir)) {
  New-Item $tempDir -ItemType directory -Force
}

# Download the installer, run it and also start the silent installation script
# which handles closing the appearing non-silent windows
# for installing the VC++ Runtime and OpenAL
$fileFullPath = Join-Path $tempDir ${packageName}Install.exe
Get-ChocolateyWebFile $packageName $fileFullPath $url
Start-Process $fileFullPath -Verb Runas -ArgumentList $silentArgs
$silentScript =  Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Definition) 'silent.ps1'
Start-ChocolateyProcessAsAdmin "& `'$silentScript`'"
