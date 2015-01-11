$packageName = 'ut-client'
$url_x64 = 'https://s3.amazonaws.com/unrealtournament/UnrealTournament-Client-XAN-2330705-Win64.zip'
$url_x86 = 'https://s3.amazonaws.com/unrealtournament/UnrealTournament-Client-XAN-2330705-Win32.zip'
$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$executable = "UnrealTournament.exe"
$shortcut_to_modify = "$Home\Desktop\UnrealTournament.exe.lnk"
$shortcut_modified = "$Home\Desktop\UnrealTournament.lnk" 

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

  if ($is64bit) {
    $url = $url_x64
  } else {
    $url = $url_x86
  }
  
Install-ChocolateyZipPackage $packageName $url $unzipLocation

$targetFilePath_x64 = "$unzipLocation\WindowsNoEditor\UnrealTournament\Binaries\Win64\$executable"
$targetFilePath_x86 = "$unzipLocation\WindowsNoEditor\UnrealTournament\Binaries\Win32\$executable"

  if ($is64bit) {
    $targetFilePath = $targetFilePath_x64
  } else {
    $targetFilePath = $targetFilePath_x86
  }

Install-ChocolateyDesktopLink $targetFilePath

Rename-Item $shortcut_to_modify $shortcut_modified




