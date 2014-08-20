$packageName = 'youtube-dl'
$url = 'http://youtube-dl.org/downloads/2014.03.04.1/youtube-dl.exe'

try {
    $destinationFolder = "$env:SystemDrive\tools\youtube-dl"

    if (-not(Test-Path $destinationFolder)) {
        New-Item -ItemType directory -Path $destinationFolder -Force
    }

    $isAdmin = ([Security.Principal.WindowsPrincipal]`
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] “Administrator”)

    if ($isAdmin) {
        Install-ChocolateyPath $destinationFolder
    } else {
        Install-ChocolateyPath $destinationFolder 'Machine'
    }

    

    Get-ChocolateyWebFile $packageName "$destinationFolder\youtube-dl.exe" $url

    Write-ChocolateySuccess $packageName
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}