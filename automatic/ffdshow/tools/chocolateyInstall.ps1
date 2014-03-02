$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
# {\{DownloadUrlx64}\} gets “misused” here as 32- and 64-bit link array due to limitations of Ketarin/chocopkgup
$urlArray = {{DownloadUrlx64}}
$url = $urlArray[0]
$url64bit = $urlArray[1]

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

# Check if 64-bit-architecture, in that case install the 32-bit and the 64-bit-version
if ($is64bit) {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url64bit
}

Install-ChocolateyPackage $packageName $fileType $silentArgs $url