$name   = 'autohotkey.install'
$url = 'http://ahkscript.org/download/1.1/AutoHotkey111401_Install.exe'
$silent = '/S'

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64  
if($is64bit) { $silent += ' /x64' }
 
Install-ChocolateyPackage $name 'exe' $silent $url
