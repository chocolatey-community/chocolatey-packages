import-module au

$releases = 'http://filehippo.com/download_audacity'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^\s*packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.BaseURL)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }

    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameBase $Latest.PackageName }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url = $download_page.Content -split "`n" | sls 'href=".+download_audacity/download/[^"]+'
    $url = $url -split '"' | select -Index 1
    $version = $download_page.Content -split "`n" | sls 'class="title-text"'
    $version = $version -split '"' | select -Last 1 -Skip 1

    $download_page = Invoke-WebRequest $url -UseBasicParsing
    $url32 = $download_page.Content -split "`n" | sls 'id="download-link"'
    $url32 = $url32 -split '"' | select -Index 1
    @{
        URL32    = 'http://filehippo.com' + $url32
        BaseUrl  = $url
        Version  = $version -split ' ' | select -Last 1
        FileType = 'exe'
    }
}
update -ChecksumFor none
