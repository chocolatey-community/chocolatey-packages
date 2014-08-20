$packageName = 'iTunes'
$url = 'https://secure-appldnld.apple.com/iTunes11/091-9745.20131022.MAN4r/iTunesSetup.exe'
$url64 = 'https://secure-appldnld.apple.com/iTunes11/091-9746.20131022.65gtB/iTunes64Setup.exe'
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