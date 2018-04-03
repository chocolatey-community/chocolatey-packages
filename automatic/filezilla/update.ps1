import-module au

$releases = 'https://filezilla-project.org/download.php?show_all=1'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url32 = $download_page.Links | ? href -match "win32\-setup\.exe$" | select -first 1 -expand href
    $url64 = $download_page.Links | ? href -match "win64\-setup\.exe$" | select -first 1 -expand href
    $version = $url32 -split '_' | select -last 1 -skip 1

    @{
        Version = $version
        URL64   = $url64
        URL32   = $url32
    }
}

update -ChecksumFor none
