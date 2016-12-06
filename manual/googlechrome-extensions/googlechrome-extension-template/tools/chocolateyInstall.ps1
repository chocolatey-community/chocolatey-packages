$bits = Get-ProcessorBits
$packageName = '-chrome'
$extensionID = ''

if ($bits -eq 64)
{
  if (Test-Path -Path "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID")
  {
    Write-Host "Extension already installed." -foreground "magenta" –backgroundcolor "blue"
  } else {
    New-Item -Path "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID"
    New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID\" -Name "update_url" -Value "https://clients2.google.com/service/update2/crx"
    New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID\" -Name "ChocolateyPackageName" -Value "$packageName"
  }
} else {
  New-Item -Path "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID"
  New-ItemProperty -Path "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID\" -Name "update_url" -Value "https://clients2.google.com/service/update2/crx"
}
