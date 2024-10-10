Import-Module Chocolatey-AU

$releases = 'https://www.gimp.org/downloads/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'" = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
      "(^[$]fallbackUrl32\s*=\s*)('.*')" = "`$1'$($Latest.FallbackURL32)'"  
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re        = '\.exe$'
  $url32     = $download_page.Links | Where-Object href -match $re | Select-Object -first 1 -expand href | ForEach-Object { 'https:' + $_ }
  
  $fallbackUrl32 = $url32 -replace "download.gimp.org/mirror", "download.gimp.org"

  $regex = "(?:[putesmigx]+)\-|\.exe"; $regex01 = "(\-)"; $regex02 = "RC"
  $version32 = ((($url32 -split("\/"))[-1]) -replace($regex,"") )
  if ($version32 -notmatch $regex02 ) { $version32 = $version32 -replace( $regex01, ".") }
  @{
    URL32    = $url32
    FallbackURL32 = $fallbackUrl32
    Version  = Get-Version $version32
  }
}

update -ChecksumFor 32
