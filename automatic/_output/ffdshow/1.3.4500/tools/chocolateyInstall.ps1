$packageName = 'ffdshow'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://dfn.dl.sourceforge.net/project/ffdshow-tryout/Official releases/generic build (stable)/ffdshow_rev4500_20130106.exe'
$url64bit = 'http://switch.dl.sourceforge.net/project/ffdshow-tryout/Official releases/64-bit/ffdshow_rev4500_20130106_x64.exe'

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

# Check if 64-bit-architecture, in that case install the 32-bit and the 64-bit-version
if ($is64bit) {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url64bit
}

Install-ChocolateyPackage $packageName $fileType $silentArgs $url