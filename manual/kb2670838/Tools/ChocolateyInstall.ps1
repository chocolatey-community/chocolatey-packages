$kb = "KB2670838"
$silentArgs = "/quiet /norestart /log:`"$env:TEMP\$kb.Install.evt`""

$os = Get-WmiObject -Class Win32_OperatingSystem
$version = [Version]$os.Version

if ($version -eq $null -or $version -lt [Version]'6.1' -or $version -ge [Version]'6.2') {
    Write-Host "Skipping installation because this hotfix only applies to Windows 7 and Windows Server 2008 R2."
    return
}

if (Get-WmiObject -Class Win32_QuickFixEngineering -Filter ('HotFixID = "{0}"' -f $kb))
{
    Write-Host "Skipping installation because hotfix $kb is already installed."
    return
}

$os = Get-WmiObject -Class Win32_OperatingSystem
if ($os.ServicePackMajorVersion -lt 1)
{
    throw 'This update requires Service Pack 1 to be installed first. The "KB976932" package may be used to install it.'
}

if ($os.ProductType -eq '1') {
    # Windows 7
    $url = "https://download.microsoft.com/download/1/4/9/14936FE9-4D16-4019-A093-5E00182609EB/Windows6.1-KB2670838-x86.msu"
    $url64 = "https://download.microsoft.com/download/1/4/9/14936FE9-4D16-4019-A093-5E00182609EB/Windows6.1-KB2670838-x64.msu"
    $checksum = 'a43037dd15993273e6dd7398345e2bd0424225be81eb8acfaa1361442ef56fce'
    $checksum64 = '9fe71e7dcd2280ce323880b075ade6e56c49b68fc702a9b4c0a635f0f1fb9db8'
} else {
    # Windows Server 2008 R2
    $url64 = "https://download.microsoft.com/download/1/4/9/14936FE9-4D16-4019-A093-5E00182609EB/Windows6.1-KB2670838-x64.msu"
    $checksum64 = '9fe71e7dcd2280ce323880b075ade6e56c49b68fc702a9b4c0a635f0f1fb9db8'
}

Install-ChocolateyPackage `
    -PackageName $kb `
    -FileType 'msu' `
    -SilentArgs $silentArgs `
    -Url $url `
    -Url64bit $url64 `
    -Checksum $checksum `
    -ChecksumType 'sha256' `
    -Checksum64 $checksum64 `
    -ChecksumType64 'sha256' `
    -ValidExitCodes @(0, 3010, 0x80240017)
