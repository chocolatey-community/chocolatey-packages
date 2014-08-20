$packageName = 'nomacs'
$fileType = 'exe'
$silentArgs = '/S'
# {\{DownloadUrlx64}\} gets “misused” here as 32- and 64-bit link array due to limitations of Ketarin/chocopkgup
$urlsArray = @('http://sourceforge.net/projects/nomacs/files/nomacs-2.0.2/nomacs-setup-2.0.2-x86.exe/download', 'http://sourceforge.net/projects/nomacs/files/nomacs-2.0.2/nomacs-setup-2.0.2-x64.exe/download')
$urlWinXp = 'http://sourceforge.net/projects/nomacs/files/nomacs-1.6.2/nomacs-setup-1.6.3-WinXP-x86.exe/download'
$url = $urlsArray[0]
$url64bit = $urlsArray[1]

try {

    # If Windows 2000/XP, download matching version
    $WinVersion = [System.Environment]::OSVersion.Version.Major
    if ($WinVersion -eq 5) {
        Write-Host 'You have Windows 2000/XP. There is no newer version than Nomacs 1.6.3 available for these operating systems.'
        $url = $urlWinXp
        $url64bit =$urlWinXp
    }


    # Else download the version for Windows Vista/7/8 or later
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}