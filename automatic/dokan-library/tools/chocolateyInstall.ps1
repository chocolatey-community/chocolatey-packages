$packageName = '{{PackageName}}'
$fileType = "exe"
$silentArgs = "/S"
$url = '{{DownloadUrl}}'
$unpath = "${Env:ProgramFiles}\Dokan\DokanLibrary\DokanUninstall.exe"
$unpathx86 = "${Env:ProgramFiles(x86)}\Dokan\DokanLibrary\DokanUninstall.exe"
$validExitCodes = @(0)

if (Test-Path $unpath) {
    $file = "$unpath"
    $installed = "True"
}
if (Test-Path $unpathx86) {
    $file = "$unpathx86"
    $installed = "True"
}

# Uninstalling previous Dokan Library first, otherwise the installer won’t work.
if ($installed) {
    Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $file  -validExitCodes $validExitCodes
    Write-Host The system must be rebooted for the changes to be completed.
}

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