try {

    $packageName = 'nlite'
    $fileType = "exe"

    $binRoot = "$env:systemdrive\tools"
    if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}

    $silentArgs = "/VERYSILENT /DIR=$binRoot\nLite"
    $url = 'http://nliteos.pcrpg.org/nlite/nLite-1.4.9.3.setup.exe'
    $referer = "http://www.nliteos.com/download.html"
    $file = "$env:TEMP\nLite-1.4.9.3.setup.exe"

    wget -P "$env:TEMP" --referer=$referer $url

    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file
    Remove-Item $file
    Write-ChocolateySuccess $packageName

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}