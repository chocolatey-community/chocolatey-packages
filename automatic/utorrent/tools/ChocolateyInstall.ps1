$packageArgs = @{
    packageName    = $env:chocolateyPackageName
    url            = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
    checksum       = '154442d57d5f785c73a20efc3f83ce95c87de46ad057eb8f386c6a451028c34e'
    silentArgs     = '/S'
    validExitCodes = @(0, 1)
}

Install-ChocolateyPackage @packageArgs

if (Get-Process 'uTorrent' -ea SilentlyContinue) {
    Stop-Process -name 'uTorrent*' -force
}
