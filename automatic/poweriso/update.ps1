import-module au

$releases = ' http://www.poweriso.com/download.htm'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
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
        URL32   = $url | ? InnerText -match '32-bit' | % href | select -First 1
        URL64   = $url | ? InnerText -match '64-bit' | % href | select -First 1
    }
}

update
