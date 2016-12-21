$versionMinusDots = "{{PackageVersion}}".Replace(".","")

$packageName = '7zip.commandline'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$extrasDir = Join-Path "$toolsDir" "7z-extra"
$url = "http://www.7-zip.org/a/7z$($versionMinusDots).exe"
$url64 = "http://www.7-zip.org/a/7z$($versionMinusDots)-x64.exe"
$extrasUrl = "http://www.7-zip.org/a/7z$($versionMinusDots)-extra.7z"

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64
Install-ChocolateyZipPackage $packageName $extrasUrl $extrasDir

Remove-Item -Path "$toolsDir\Uninstall.exe"

if (Get-ProcessorBits 32) {
  # generate ignore for x64\7za.exe
  New-Item "$extrasDir\x64\7za.exe.ignore" -Type file -Force | Out-Null
} else {
  #generate ignore for 7za.exe and let x64 version pick up and shim
  New-Item "$extrasDir\7za.exe.ignore" -Type file -Force | Out-Null
}
