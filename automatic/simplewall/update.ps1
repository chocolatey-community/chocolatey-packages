import-module au

$releases = 'https://github.com/henrypp/simplewall/releases/latest'

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url_i = $download_page.links | ? href -match '.exe$' | select -First 1 -expand href
    $url_p = $download_page.links | ? href -match '.zip$' | select -First 1 -expand href
    $version = $url_i -split '-' | select -First 1 -Skip 1

    @{
        Version = $version
        URL32_i = 'https://github.com' + $url_i
        URL32_p = 'https://github.com' + $url_p
    }
}

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none
}
