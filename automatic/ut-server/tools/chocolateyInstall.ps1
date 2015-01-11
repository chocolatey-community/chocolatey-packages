$packageName = 'ut-server'
$url = 'https://s3.amazonaws.com/unrealtournament/UnrealTournament-Server-XAN-2330705-Win64.zip'
$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$executable = "UnrealTournamentServer.exe"
$shortcut_to_modify = "$Home\Desktop\UnrealTournamentServer.exe.lnk"
$shortcut_modified = "$Home\Desktop\UnrealTournamentServer.lnk" 

Install-ChocolateyZipPackage $packageName $url $unzipLocation

$targetFilePath = "$unzipLocation\WindowsServer\UnrealTournament\Binaries\Win64\$executable"

Install-ChocolateyDesktopLink $targetFilePath

Rename-Item $shortcut_to_modify $shortcut_modified




