import-module au

$releases = 'http://www.glarysoft.com/absolute-uninstaller/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

    #$version  = $download_page.ParsedHtml.body.getElementsByClassName('au_index_ver') | select -first 1 -expand "innerText";
    $version = ($download_page.Content -split "`n" | sls au_index_ver) -split '<|>'
    $version =  $version | ? { [version]::TryParse($_, [ref]($__)) }

    @{ URL32 = $url; Version = $version }
}

update -ChecksumFor 32
