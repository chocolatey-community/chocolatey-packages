import-module au

$releases = "https://api.github.com/repos/notepad-plus-plus/notepad-plus-plus/releases"

function global:au_SearchReplace {
  @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
 }

function global:au_GetLatest {
    $header = @{
        "Authorization" = "token $env:github_api_key"
      }

    $download_page = Invoke-WebRequest $releases -UseBasicParsing -Headers $header | ConvertFrom-Json
    $url_i         = $download_page.assets.browser_download_url -match '.exe$' | select -First 2 -Skip 1
    $url_p         = $download_page.assets.browser_download_url -match '.7z$' | select -First 6

    @{
        Version = Get-Version ( $url_i -notmatch 'x64' | select -First 1 )
        URL32_i = $url_i -notmatch 'x64' | select -First 1
        URL64_i = $url_i -match 'x64'  | select -First 1
        URL32_p = $url_p -notmatch 'x64' -notmatch 'minimalist' -notmatch 'arm64' | select -First 1
        URL64_p = $url_p -match 'x64' -notmatch 'minimalist' -notmatch 'arm64' | select -First 1
    }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none
}
