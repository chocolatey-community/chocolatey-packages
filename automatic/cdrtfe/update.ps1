import-module au

$releases = 'http://cdrtfe.sourceforge.net/cdrtfe/download_en.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = '\.exe$'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $url -split '-|.exe' | select -Last 1 -Skip 1

    @{ URL32 = $url; Version = $version }
}

try {
  update -ChecksumFor 32
} catch {
  if ($_ -notmatch "Can't validate URL") {
    throw $_
  } else {
    Write-Host "Can't validate URL while checking version ignored, package might have an update"
  }
}
