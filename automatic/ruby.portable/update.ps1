Import-Module Chocolatey-AU

$releases = 'https://rubyinstaller.org/downloads/archives/'

function global:au_SearchReplace {
  $installScript = (Join-Path -Path 'tools' -ChildPath 'chocolateyInstall.ps1')
  $verificationFile = (Join-Path -Path 'legal' -ChildPath 'VERIFICATION.txt')
  $searchReplaceTargets = (${installScript},${verificationFile})
  foreach ($target in ${searchReplaceTargets}) {
    $target = "$(Join-Path -Path $PSScriptRoot -ChildPath ${target})"
  }

  $replacements = [ordered]@{}
  $replacements[$installScript] = @{
    "(?i)(^`$exeName\s*=\s*)(?:'.*')" = "`$1'$($Latest.FileName64)'"
  }
  $replacements[${verificationFile}] = @{
    "(?i)(^\s+)(?:<http.*\.7z>\.$)"         = "`$1<$($Latest.URL64)>."
    "(?i)(^\s+)(?:[a-z0-9]{64}$)"           = "`$1$($Latest.Checksum64)"
    "(?i)(^\s+Get.*-Url\s*)(?:http.*\.7z$)" = "`$1$($Latest.URL64)"
    "(?i)(^<http.*>\.$)"                    = "<$($Latest.LicenseUrl)>."
  }

  return $replacements
}

function global:au_BeforeUpdate {
  [CmdletBinding()]
  param($Package)

  if (${MyInvocation}.InvocationName -ne '.') {
    ${Latest}.LicenseUrl = ${Package}.nuspecXml.package.metadata.licenseUrl
    $outputFile = "$(Join-Path -Path ${PSScriptRoot} -ChildPath (
      Join-Path -Path 'legal' -ChildPath 'LICENSE.txt'
    ))"

    try {
      if (Test-Path ${outputFile}) {
        Remove-Item -LiteralPath ${outputFile} -Force -ErrorAction Stop
      }
      Invoke-WebRequest -Uri ${Latest}.LicenseUrl -OutFile ${outputFile} -ErrorAction Stop
      if (-not (Select-String -Path ${outputFile} -Pattern 'You may distribute the software' -SimpleMatch -Quiet)) {
        throw 'The License has changed, please verify redistribution rights and update the license check.'
      }
    } catch {
      Write-Error "License fetch/verify failed: '$_'."
      throw
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
  $x64releaseUrls = $releaseUrls | Where-Object href -Match $re64 | Select-Object -First 3

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
      '3.1' {
        '3.1.3'
      }
      default {
        '0.0.0'
      }
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
  $releaseUrls = $download_page.links | Where-Object href -Match $re | Where-Object {
    $_ -notmatch 'doc'
  }

  @{
    Streams = GetStreams $releaseUrls
  }
}

update -ChecksumFor none
