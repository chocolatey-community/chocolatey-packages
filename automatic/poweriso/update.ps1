import-module au
import-module "$PSScriptRoot\..\..\extensions\extensions.psm1"

$releases = 'https://www.poweriso.com/download.htm'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(Get\-WebContent\s*)'.*'"        = "`$1'$releases'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $url = $download_page.links | ? class -eq 'download_link'
    @{
        Version = ($url[0].InnerText -split ' ' | Select -Last 1 -Skip 1).Substring(1)
    }
}

try {
  update
} catch {
  Write-Host "Ignored until someone can be bothered to fix the parsing"
  return "ignore"
}
