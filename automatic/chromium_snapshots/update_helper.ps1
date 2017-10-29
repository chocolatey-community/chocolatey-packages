
  if (!(Test-Path "$PSScriptRoot\tools" -PathType Container)) {
  New-Item -ItemType Directory "$PSScriptRoot\tools"
  Copy-Item "$PSScriptRoot\..\chromium\tools" "$PSScriptRoot" -Force -Recurse
  }
  if (!(Test-Path "$PSScriptRoot\legal" -PathType Container)) {
  New-Item -ItemType Directory "$PSScriptRoot\legal"
  Copy-Item "$PSScriptRoot\..\chromium\legal" "$PSScriptRoot" -Force -Recurse
  }
$myFunction = 'function Get-CompareVersion {
  param(
    [string]$version,
    [string]$notation,
    [string]$package
  )
    $version = $version -replace($notation,"")
    [array]$key = Get-UninstallRegistryKey -SoftwareName "$package*"
    if ($version -eq ( $key.Version )) {
      Write-Host "$package $version is already installed."
      return
    }
  }
'
remove-item "$PSScriptRoot\tools\chocolateyInstall.ps1" -Force
$filename = "$PSScriptRoot\..\chromium\tools\chocolateyInstall.ps1"
foreach ($line in [System.IO.File]::ReadLines($filename)) {
    if ( $line -match 'toolsDir =' ) {
        $line = ($myFunction + '$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"`
$version = ""`
. $toolsDir\helper.ps1`
Get-CompareVersion -version $version -notation "-snapshots" -package "chromium"');
    }	
    $line |  Out-File -Append "$PSScriptRoot\tools\chocolateyInstall.ps1"
}
