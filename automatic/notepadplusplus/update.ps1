import-module au

$releases = 'https://notepad-plus-plus.org/download'

function global:au_SearchReplace {
  @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
 }

function global:au_GetLatest {
    $root          = (Split-Path $releases -Parent).Replace(":\\", "://")
    $download_page = Invoke-WebRequest $releases -UseBasicParsing
    $url_i         = $download_page.Links | ? href -match '.exe$' | % href
    $url_p         = $download_page.Links | ? href -match '.7z$' | % href

    @{
        Version = Split-Path (Split-Path $url_i[0]) -Leaf
        URL32_i = $root + ($url_i -notmatch 'x64')
        URL64_i = $root + ($url_i -match 'x64')
        URL32_p = $root + ($url_p -notmatch 'x64' -notmatch 'minimalist')
        URL64_p = $root + ($url_p -match 'x64' -notmatch 'minimalist')
    }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none
}
