import-module au
$releases = 'https://www.videolan.org/vlc/download-windows.html'

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | % href
    $version  = $url[0] -split '-' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL32        = 'http:' + ( $url -match 'win32' | select -first 1 )
        URL64        = 'http:' + ( $url -match 'win64' | select -first 1 )
    }
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor none
}
