$packageName = '{{PackageName}}'
$fileType = 'msi'
$silentArgs = '/quiet'
$url = $('' +
  'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96' +
  '%7D%26iid%3D%7B00000000-0000-0000-0000-000000000000%7D%26lang%3Den%26browser%3D3%26' +
  'usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers/edgedl/chrome/' +
  'install/GoogleChromeStandaloneEnterprise.msi')
$version = '{{PackageVersion}}'

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
