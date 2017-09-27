Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$domain   = 'https://slproweb.com'
$releases = "$domain/products/Win32OpenSSL.html"

$padUnderVersion = '1.1.1'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*`""   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*`"" = "`${1}$($Latest.FileName64)`""
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = 'Win32.*Light.*\.exe$'
  $url32 = $domain + ($download_page.Links | ? href -match $re | select -first 1 -expand href)

  $re = 'Win64.*Light.*\.exe$'
  $url64 = $domain + ($download_page.links | ? href -match $re | select -first 1 -expand href)

  $verRe = '[\-]|\.exe'
  $version32 = ($url32 -split "$verRe" | select -last 1 -skip 1) -replace '_','.'
  $version64 = ($url64 -split "$verRe" | select -last 1 -skip 1) -replace '_','.'
  if ($version32 -ne $version64) {
    throw "32bit version do not match the 64bit version"
  }
  $rev = ([byte][char]$version32[$version32.Length - 1]) - 97
  $version32 = $version32 -replace '[a-z]+$',".$rev"

  if ([version]$version32 -lt [version]'1.1.1') {
    # Because previous package updates used dates, we need a number that ends up being larger
    $revisionLen = '8' # Will end up with version '1.1.0.40000000'
  } else {
    $revisionLen = '4'
  }

  @{
    URL32 = $url32
    URL64 = $url64
    Version = Get-PaddedVersion $version32 -OnlyBelowVersion $padUnderVersion -RevisionLength $revisionLen
    PackageName = 'OpenSSL.Light'
  }
}

update -ChecksumFor none
