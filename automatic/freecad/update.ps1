import-module au

if (!$PSScriptRoot) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\update_helper.ps1"

$PreUrl = 'https://github.com'
$releases = "$PreUrl/FreeCAD/FreeCAD/releases"
$softwareName = 'FreeCAD'

function global:au_SearchReplace {
    if ( [string]::IsNullOrEmpty($Latest.URL32) ) {
        @{
            ".\tools\chocolateyInstall.ps1"   = @{
                "(?i)(^\s*packageName\s*=\s*)'.*'"                 = "`$1'$($Latest.PackageName)'"
                "(?i)(^\s*fileType\s*=\s*)('.*')"                  = "`$1'$($Latest.fileType)'"
                "(?i)(^\s*url64\s*=\s*)('.*')"                     = "`$1'$($Latest.URL64)'"
                "(?i)(^\s*checksum64\s*=\s*)('.*')"                = "`$1'$($Latest.Checksum64)'"
                "(?i)(^\s*checksumType64\s*=\s*)('.*')"            = "`$1'$($Latest.ChecksumType64)'"
                "(?i)(^\s*softwareName\s*=\s*)'.*'"                = "`$1'$($softwareName)'"
            }
            ".\freecad.nuspec"                = @{
                "(?i)(^\s*\<id\>).*(\<\/id\>)"                     = "`${1}$($Latest.PackageName)`${2}"
                "(?i)(^\s*\<title\>).*(\<\/title\>)"               = "`${1}$($Latest.Title)`${2}"
                "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
            }
            ".\tools\chocolateyUninstall.ps1" = @{
                "(?i)(^\s*packageName\s*=\s*)'.*'"                 = "`$1'$($Latest.PackageName)'"
                "(?i)^(\s*softwareName\s*=\s*)'.*'"                = "`$1'$($softwareName)'"
                "(?i)(^\s*fileType\s*=\s*)('.*')"                  = "`$1'$($Latest.fileType)'"
            }
        }
    } else {
        @{
            ".\tools\chocolateyInstall.ps1"   = @{
                "(?i)(^\s*packageName\s*=\s*)'.*'"                 = "`$1'$($Latest.PackageName)'"
                "(?i)(^\s*fileType\s*=\s*)('.*')"                  = "`$1'$($Latest.fileType)'"
                "(?i)(^\s*url\s*=\s*)('.*')"                       = "`$1'$($Latest.URL32)'"
                "(?i)(^\s*url64\s*=\s*)('.*')"                     = "`$1'$($Latest.URL64)'"
                "(?i)(^\s*checksum\s*=\s*)('.*')"                  = "`$1'$($Latest.Checksum32)'"
                "(?i)(^\s*checksum64\s*=\s*)('.*')"                = "`$1'$($Latest.Checksum64)'"
                "(?i)(^\s*checksumType\s*=\s*)('.*')"              = "`$1'$($Latest.ChecksumType32)'"
                "(?i)(^\s*checksumType64\s*=\s*)('.*')"            = "`$1'$($Latest.ChecksumType64)'"
                "(?i)(^\s*softwareName\s*=\s*)'.*'"                = "`$1'$($softwareName)'"
            }
            ".\freecad.nuspec"                = @{
                "(?i)(^\s*\<id\>).*(\<\/id\>)"                     = "`${1}$($Latest.PackageName)`${2}"
                "(?i)(^\s*\<title\>).*(\<\/title\>)"               = "`${1}$($Latest.Title)`${2}"
                "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
            }
            ".\tools\chocolateyUninstall.ps1" = @{
                "(?i)(^\s*packageName\s*=\s*)'.*'"                 = "`$1'$($Latest.PackageName)'"
                "(?i)^(\s*softwareName\s*=\s*)'.*'"                = "`$1'$($softwareName)'"
                "(?i)(^\s*fileType\s*=\s*)('.*')"                  = "`$1'$($Latest.fileType)'"
            }
        }
    }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -FileNameBase "$($Latest.PackageName)"
  $types = @("7z", "exe", "json")
  foreach ($file in $types) {
    Remove-Item ".\tools\*.${file}" -Force # Removal of downloaded files
  }
  # Change the install file based on $Latest.URL32 and $Latest.fileType
  if ([string]::IsNullOrEmpty($Latest.URL32)) {
    cp "$PSScriptRoot\install64.tmp" "$PSScriptRoot\tools\chocolateyinstall.ps1" -Force
  }
  else {
    cp "$PSScriptRoot\install32.tmp" "$PSScriptRoot\tools\chocolateyinstall.ps1" -Force
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $streams = [ordered] @{
    dev      = Get-FreeCad -Title "${softwareName}" -kind "dev"
    stable   = Get-FreeCad -Title "${softwareName}"
    portable = Get-FreeCad -Title "${softwareName}" -kind "portable"
  }
  return @{ Streams = $streams }
}

update -ChecksumFor none
