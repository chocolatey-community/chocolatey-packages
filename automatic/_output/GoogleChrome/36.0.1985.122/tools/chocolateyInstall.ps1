$packageName = 'GoogleChrome'
$fileType = 'msi'
$silentArgs = '/quiet'
$url = 'https://dl.google.com/tag/s/appguid={8A69D345-D564-463C-AFF1-A69D9E530F96}&iid={00000000-0000-0000-0000-000000000000}&lang=en&browser=3&usagestats=0&appname=Google%2520Chrome&needsadmin=prefers/edgedl/chrome/install/GoogleChromeStandaloneEnterprise.msi'
$version = '36.0.1985.122'

function Find-CID {
  param([String]$croot, [string]$cdname, [string]$ver)

  if (Test-Path $croot) {
    Get-ChildItem -Force -Path $croot | foreach {
      $CurrentKey = (Get-ItemProperty -Path $_.PsPath)
      if ($CurrentKey -match $cdname -and $CurrentKey -match $ver) {
        return $CurrentKey.PsChildName
      }
    }
  }
  return $null
}

$uroot = 'HKLM:\SOFTWARE\Google\Update\Clients'
$uroot64 = 'HKLM:\SOFTWARE\Wow6432Node\Google\Update\Clients'

try {

    $msid = Find-CID $uroot "Google Chrome binaries" "$version"
    if ($msid -eq $null) {
    # try 64bit registry
        $msid = Find-CID $uroot64 "Google Chrome binaries" "$version"
    }
    if ($msid -ne $null) {
       Write-Host "Google Chrome $version is already installed."
    } else {
        Install-ChocolateyPackage $packageName $fileType $silentArgs $url
    }

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw 
}
