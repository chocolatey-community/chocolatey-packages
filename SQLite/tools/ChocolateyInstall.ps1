$binDir = join-path $env:ChocolateyInstall "bin"
Install-ChocolateyZipPackage '{{PackageName}}' '{{DownloadUrl}}' $binDir