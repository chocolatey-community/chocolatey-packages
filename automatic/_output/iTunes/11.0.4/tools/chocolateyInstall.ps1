$packageName = 'iTunes'
$url = 'http://appldnld.apple.com/iTunes11/091-6059.20130605.205Rf/iTunesSetup.exe'
$url64 = 'http://appldnld.apple.com/iTunes11/091-6060.20130605.Azqw2/iTunes64Setup.exe'
$fileType = 'msi'
$silentArgs = '/quiet'
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\$packageName`Install.exe"

try {
    if (-not (Test-Path $filePath)) {
        New-Item -ItemType directory -Path $filePath
    }

    Get-ChocolateyWebFile $packageName $fileFullPath $url $url64

    Start-Process "7za" -ArgumentList "x -o`"$filePath`" -y `"$fileFullPath`"" -Wait

    $packageName = 'appleapplicationsupport'
    $file = "$filePath\AppleApplicationSupport.msi"
    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file

    $processor = Get-WmiObject Win32_Processor
    $is64bit = $processor.AddressWidth -eq 64

    $packageName = 'applemobiledevicesupport'
    if ($is64bit) {$file = "$filePath\AppleMobileDeviceSupport64.msi"} else {$file = "$filePath\AppleMobileDeviceSupport.msi"}
    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file

    $packageName = 'bonjour'
    if ($is64bit) {$file = "$filePath\Bonjour64.msi"} else {$file = "$filePath\Bonjour.msi"}
    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file

    $packageName = 'itunes'
    if ($is64bit) {$file = "$filePath\iTunes64.msi"} else {$file = "$filePath\iTunes.msi"}
    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file

    Write-ChocolateySuccess "$packageName"
} catch {
    Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
    throw
}