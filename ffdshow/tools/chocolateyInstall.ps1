$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

# Check if 64-bit-architecture, in that case install the 32-bit and the 64-bit-version
if ($is64bit) {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url64bit
}

Install-ChocolateyPackage $packageName $fileType $silentArgs $url