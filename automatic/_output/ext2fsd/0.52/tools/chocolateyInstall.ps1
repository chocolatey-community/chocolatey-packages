$packageName = 'ext2fsd'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/ext2fsd/files/Ext2fsd/0.52/Ext2Fsd-0.52.exe/download'

# Set compatibility mode to Windows 7 if operating system is Windows 8 or higher.
$WindowsVersion = (Get-WmiObject -class Win32_OperatingSystem).Version
if ($WindowsVersion -ge "6.2.9200") {
    if (-not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags" -Name Layers 
    }
    New-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" -propertyType String -Name "$env:temp\chocolatey\$packageName\$packageName`Install.$fileType" -value "~ WIN7RTM"
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url
    # Delete compatibility mode for ext2fsd installer, because it’s not needed anymore
    Remove-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" -Name "$env:temp\chocolatey\$packageName\$packageName`Install.$fileType"
} else {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url
}