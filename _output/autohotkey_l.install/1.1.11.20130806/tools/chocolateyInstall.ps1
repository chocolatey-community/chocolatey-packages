$name   = 'autohotkey_l.install'
$url = 'http://l.autohotkey.net/v/AutoHotkey111102_Install.exe'
$silent = '/S'

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64  
if($is64bit) { $silent += ' /x64' }
 
Install-ChocolateyPackage $name 'exe' $silent $url
