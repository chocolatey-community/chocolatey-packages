$packageName = '{{PackageName}}'
$fileType = 'msi'
$silentArgs = '/quiet'
$url = '{{DownloadUrl}}'
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
