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

$cname = 'libreoffice'
$version = '4.2.1'

#try {
#  $clsid='{F1EE568A-171F-4C06-9BE6-2395BED067A3}'

  $uroot = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
  $uroot64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
  $msid = Find-CID $uroot "LibreOffice" "$version"
  if ($msid -eq $null) {
    # try 64bit registry
    $msid = Find-CID $uroot64 "LibreOffice" "$version"
  }
  if ($msid -ne $null) {
    Write-Host "LibreOffice is already installed!"
  } else {

   $downUrl = 'http://download.documentfoundation.org/libreoffice/stable/4.2.1/win/x86/LibreOffice_4.2.1_Win_x86.msi'
   # installer, will assert administrative rights
   Install-ChocolateyPackage 'libreoffice' 'MSI' '/passive' "$downUrl" -validExitCodes @(0)
   # the following is all part of error handling
   Write-ChocolateySuccess 'libreoffice'
  }
#} catch {
#  Write-ChocolateyFailure 'libreoffice' "$($_.Exception.Message)"
#  throw 
#}
