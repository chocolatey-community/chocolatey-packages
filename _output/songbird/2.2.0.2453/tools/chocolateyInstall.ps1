$packageName = 'songbird'
$fileType = 'exe'
$url = 'http://www.getsongbird.com/desktop/index.php?download=GSB_windows'
$silentArgs = '/S'

# Set compatibility mode to Windows 7 if operating system is Windows 8 or higher.
$WindowsVersion = (Get-WmiObject -class Win32_OperatingSystem).Version
if ($WindowsVersion -ge '6.2.9200') {

    $regDir = 'HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'
    $file = "$env:TEMP\chocolatey\$packageName\${packageName}Install.exe"

    if (-not (Test-Path $regDir)) {New-Item $regDir}
    New-ItemProperty -Path $regDir -PropertyType String -Name $file -Value '~ WIN7RTM' -Force

    Install-ChocolateyPackage $packageName $fileType $silentArgs $url

    # Delete compatibility mode for installer, because it’s not needed anymore
    Remove-ItemProperty -Path $regDir -Name $file
}

Install-ChocolateyPackage $packageName $fileType $silentArgs $url