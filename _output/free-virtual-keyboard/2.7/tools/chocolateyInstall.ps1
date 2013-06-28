$packageName = 'free-virtual-keyboard'
$url = 'http://www.freevirtualkeyboard.com/FreeVK.exe'
$binRoot = "$env:systemdrive\tools"
md -Path "$binRoot\Free Virtual Keyboard"
$fileFullPath = "$binRoot\Free Virtual Keyboard\FreeVK.exe"

Get-ChocolateyWebFile $packageName "$fileFullPath" $url

$desktop = "$([Environment]::GetFolderPath("Desktop"))"
$startMenu = "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))\Programs"

Install-ChocolateyDesktopLink $fileFullPath
Rename-Item -Path "$desktop\FreeVK.exe.lnk" -NewName "Free Virtual Keyboard.lnk"
Copy-Item "$desktop\Free Virtual Keyboard.lnk" -Destination "$startMenu"