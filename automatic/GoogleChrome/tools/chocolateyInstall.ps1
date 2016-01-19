$packageName = '{{PackageName}}'
$fileType = 'msi'
$silentArgs = '/quiet'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$version = '{{PackageVersion}}'

# This function checks if Chrome 32-bit is installed
# on a 64-bit system
function Check-Chrome32bitInstalled {

  $registryPath = 'HKLM:\SOFTWARE\WOW6432Node\Google\Update\ClientState\'

  if (Test-Path $registryPath) {
    Get-ChildItem $registryPath | ForEach-Object {
      if ((Get-ItemProperty $_.pspath).ap -eq '-multi-chrome') {
        return $true
      }
    }
  }
}

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


$msid = Find-CID $uroot "Google Chrome binaries" "$version"
if ($msid -eq $null) {
# try 64bit registry
  $msid = Find-CID $uroot64 "Google Chrome binaries" "$version"
}
if ($msid -ne $null) {
   Write-Output "Google Chrome $version is already installed."
} else {

  # If Chrome 32-bit is already installed on a 64-bit system,
  # keep installing the 32-bit version, otherwise install the
  # 64-bit version on 64-bit systems
  if (Check-Chrome32bitInstalled) {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url
  } else {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
  }

}
