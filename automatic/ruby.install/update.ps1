Import-Module Chocolatey-AU

$releases = 'https://rubyinstaller.org/downloads/archives/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*fileType\s*=\s*)('.*')"           = "`$1'$($Latest.FileType)'"
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

  $re64 = 'x64\.exe$'
  $x64releaseUrls = $releaseUrls | Where-Object href -match $re64

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

    $streams.$versionTwoPart = @{
      URL64 = $url64
      Version = Get-FixVersion -Version $version -OnlyFixBelowVersion "2.5.4"
    }
  }

  Write-Information $streams.Count 'streams collected'
  $streams
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe$'
  $releaseUrls = $download_page.links | Where-Object href -match $re | Where-Object {
    $_ -notmatch 'devkit'
  }

  @{
    Streams = GetStreams $releaseUrls
  }
}

if ($MyInvocation.InvocationName -ne '.') {
  # Run the update only if script is not sourced by the virtual package ruby.
  update -ChecksumFor none
}
