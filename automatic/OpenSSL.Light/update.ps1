Import-Module AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$domain   = 'https://slproweb.com'
$releases = "$domain/products/Win32OpenSSL.html"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_AfterUpdate { Set-DescriptionFromReadme -SkipFirst 1 }

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
  $version32 = $url32 -split "$verRe" | select -last 1 -skip 1
  $version64 = $url64 -split "$verRe" | select -last 1 -skip 1
  if ($version32 -ne $version64) {
    throw "32bit version do not match the 64bit version"
  }

  if (Test-Path "$PSScriptRoot\LastVersion.txt") {
    $lastVersion = Get-Content "$PSScriptRoot\LastVersion.txt"
    if ($lastVersion -ne $version32) { $global:au_Force = $true }
    }
    Set-Content "$PSScriptRoot\LastVersion.txt" -Value $version32

  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version32 -replace '_','.' -split '[a-z]' | select -first 1
  }
}

update -ChecksumFor none
