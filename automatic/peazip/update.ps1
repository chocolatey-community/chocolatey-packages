import-module au

$releases = 'https://github.com/giorgiotani/PeaZip/releases'

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $url32  = $download_page.links | ? href -match 'WINDOWS.exe$' | select -First 1 -expand href
  $url64 = $download_page.links | ? href -match 'WIN64.exe$' | select -First 1 -expand href
  $version   = $url32 -split '-|.WINDOWS.exe' | select -Last 1 -Skip 1
  $version64   = $url64 -split '-|.WIN64.exe' | select -Last 1 -Skip 1

  if ($version -ne $version64) {
    throw "32-bit and 64-bit version do not match. Please investigate."
  }

  return @{
    URL32    = 'https://github.com' + $url32
    URL64    = 'https://github.com' + $url64
    Version  = $version
  }
}

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

update -ChecksumFor none
