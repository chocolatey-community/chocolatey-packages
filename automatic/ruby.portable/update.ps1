Import-Module Chocolatey-AU

$releases = 'https://rubyinstaller.org/downloads/archives/'
$fixBelowVersion = '3.1.3'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }

    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(\s+x64:).*"              = "`${1} $($Latest.URL64)"
      "(?i)(checksum64:).*"          = "`${1} $($Latest.Checksum64)"
      "(?i)(Get-RemoteChecksum).*"   = "`${1} $($Latest.URL64)"
      "(?i)(is obtained from:\s*).*" = "`${1} $($Latest.LicenseUrl)"
    }
  }
}

function global:au_BeforeUpdate($Package) {
  if ($MyInvocation.InvocationName -ne '.') {
    $Latest.LicenseURl = $Package.nuspecXml.package.metadata.licenseUrl
    $outputFile = "$PSScriptRoot\legal\LICENSE.txt"

    if (Test-Path $outputFile) {
      Remove-Item $outputFile
    }

    Invoke-WebRequest -Uri $Latest.LicenseUrl -OutFile $outputFile
    $content = Get-Content $outputFile

    $hasMatch = $content | Where-Object {
      $_ -match "You may distribute the software"
    }

    if (!$hasMatch) {
      throw "The License has changed, please verify redistribution rights and update the license check."
    }
  }

  Get-RemoteFiles -Purge -NoSuffix
}

function GetStreams() {
  param($releaseUrls)
  $streams = @{ }

  $re64 = 'x64\.7z$'
  # Temporarily limit the amount of URLs to use until we have at least
  # one approved version. Then slowly increase the limit so we do not
  # overwhelm anything.
  $x64releaseUrls = $releaseUrls | Where-Object href -match $re64 | Select-Object -First 3

  $x64releaseUrls | ForEach-Object {
    $version = $_ -replace '\-([\d]+)', '.$1' -replace 'rubyinstaller.' -replace 'ruby.' -split '/' | Select-Object -Last 1 -Skip 1
    if ($version -match '[a-z]') {
      Write-Information "Skipping prerelease: '$version'"
      return
    }
    $versionTwoPart = $version -replace '([\d]+\.[\d]+).*', "`$1"

    if ($streams.$versionTwoPart) {
      return
    }

    $url64 = $_ | Select-Object -ExpandProperty href

    if (!$url64) {
      Write-Information "Skipping due to missing installer: '$version'"
      return
    }

    $fixBelowVersion = switch ($versionTwoPart) {
      '3.1' { '3.1.3' }
      default { '0.0.0' }
    }

    $streams.$versionTwoPart = @{
      URL64   = $url64
      Version = Get-FixVersion -Version $version -OnlyFixBelowVersion $fixBelowVersion
    }
  }

  Write-Information $streams.Count 'streams collected'
  $streams
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.7z$'
  $releaseUrls = $download_page.links | Where-Object href -match $re | Where-Object {
    $_ -notmatch 'doc'
  }

  @{
    Streams = GetStreams $releaseUrls
  }
}

update -ChecksumFor none
