$cname = '{{PackageName}}'
$version = '{{PackageVersion}}'

function Find-CID {
  param([String]$croot, [string]$cdname, [string]$ver)

  if (Test-Path $croot) {
    Get-ChildItem -Force -Path $croot | foreach {
      $CurrentKey = (Get-ItemProperty -Path $_.PsPath)
      if ($CurrentKey -match $cdname -and $CurrentKey -like "*$ver*") {
        return $CurrentKey.PsChildName
      }
    }
  }
  return $null
}

#try {
  $uroot = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
  $uroot64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
  $msid = Find-CID $uroot "LibreOffice" "$version"
  if ($msid -eq $null) {
    # try 64bit registry
    $msid = Find-CID $uroot64 "LibreOffice" "$version"
  }
  if ($msid -eq $null) {
    Write-Host "$cname is not found."
  } else {

    Uninstall-ChocolateyPackage '{{PackageName}}' 'MSI' "$msid" -validExitCodes @(0)
    Write-ChocolateySuccess '{{PackageName}}'
  }
#} catch {
#  Write-ChocolateyFailure '{{PackageName}}' "$($_.Exception.Message)"
#  throw 
#}
