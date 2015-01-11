$packageName = 'oscillation'
$url = 'http://workproaudio.com/productos/Docs/Software/oscillation.exe'
$fileFullPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\oscillation.exe"
$shortcut_to_modify = "$Home\Desktop\oscillation.exe.lnk"
$shortcut_modified = "$Home\Desktop\OSCillation.lnk"

Get-ChocolateyWebFile $packageName $fileFullPath $url

Install-ChocolateyDesktopLink $fileFullPath

Rename-Item $shortcut_to_modify $shortcut_modified