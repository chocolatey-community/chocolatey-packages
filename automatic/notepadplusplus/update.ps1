import-module au


function global:au_SearchReplace {
  @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
 }

function global:au_GetLatest {
    $tags = "https://github.com/notepad-plus-plus/notepad-plus-plus/tags"
    $release = Invoke-WebRequest $tags -UseBasicParsing
    $new = (( $release.links -match "v\d+\.\d+\.\d+" ) -split " " | select -First 10 | Select -Last 1 )
    $new = $new.Substring(0,$new.Length-1)
    $releases = "https://notepad-plus-plus.org/downloads/$new"
    $root          = "https://notepad-plus-plus.org"
    $download_page = Invoke-WebRequest $releases -UseBasicParsing
    $url_i         = $download_page.Links | ? href -match '.exe$' | Select-Object -Last 2 | % href
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
