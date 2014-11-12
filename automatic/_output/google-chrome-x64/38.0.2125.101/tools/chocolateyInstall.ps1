$packageName = 'google-chrome-x64'
$fileType = 'msi'
$silentArgs = '/quiet /norestart'
$url = 'https://dl.google.com/tag/s/appguid={00000000-0000-0000-0000-000000000000}&iid={00000000-0000-0000-0000-000000000000}&lang=en&browser=4&usagestats=0&appname=Google Chrome&needsadmin=true/dl/chrome/install/googlechromestandaloneenterprise64.msi'
$version = '38.0.2125.101'

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

$uroot = 'HKLM:\SOFTWARE\Google\Update\ClientState'
$uroot64 = 'HKLM:\SOFTWARE\Wow6432Node\Google\Update\ClientState'

try {

  $msid = Find-CID $uroot "x64-stable-multi-chrome" "$version"
  if ($msid -eq $null) {
  # try 64bit registry
    $msid = Find-CID $uroot64 "x64-stable-multi-chrome" "$version"
  }
  if ($msid -ne $null) {
     Write-Host "Google Chrome $version (64-bit) is already installed."
  } else {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
