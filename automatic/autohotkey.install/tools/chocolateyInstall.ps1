$name   = 'autohotkey.install'
$url = '{{DownloadUrl}}'
$url64 = $url
$silent = '/S'

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
if($is64bit) { $silent += ' /x64' }

Install-ChocolateyPackage $name 'exe' $silent $url $url64
