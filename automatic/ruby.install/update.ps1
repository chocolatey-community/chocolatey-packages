Import-Module Chocolatey-AU

$releases = 'https://rubyinstaller.org/downloads/archives/'

function global:au_SearchReplace {
  $installScript = (Join-Path -Path 'tools' -ChildPath 'chocolateyInstall.ps1')
  $verificationFile = (Join-Path -Path 'legal' -ChildPath 'VERIFICATION.txt')
  $searchReplaceTargets = (${installScript},${verificationFile})
  foreach ($target in ${searchReplaceTargets}) {
    $target = "$(Join-Path -Path ${PSScriptRoot} -ChildPath ${target})"
  }

  $replacements = [ordered]@{}
  $replacements[${installScript}] = @{
    "(?i)(^`$exeName\s*=\s*)(?:'.*')"   = "`$1'$($Latest.FileName64)'"
    "(?i)(^\s*fileType\s*=\s*)(?:'.*')" = "`$1'$($Latest.FileType)'"
  }
  $replacements[${verificationFile}] = @{
    "(?i)(^\s+)(?:<http.*\.exe>\.$)"         = "`$1<$($Latest.URL64)>."
    "(?i)(^\s+)(?:[a-z0-9]{64}$)"            = "`$1$($Latest.Checksum64)"
    "(?i)(^\s+Get.*-Url\s*)(?:http.*\.exe$)" = "`$1$($Latest.URL64)"
    "(?i)(^<http.*>\.$)"                     = "<$($Latest.LicenseUrl)>."
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
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)]
    [Uri[]] $releaseUrls
  )

  $streams = [ordered]@{}
  foreach ($link in $releaseUrls) {
    $href = if (${link} -is [System.Management.Automation.PSObject] -and ${link}.PSObject.Properties.Match('href')) {
      ${link}.href
    } else {
      ${link}.ToString()
    }
    if (${href} -notmatch 'x64\.exe$') {
      continue
    }

    $file = [IO.Path]::GetFileNameWithoutExtension(${href})
    $m = [regex]::Match(${file}, '([0-9]+\.[0-9]+(?:\.[0-9]+)?)')
    if (-not ${m}.Success) {
      Write-Verbose "Skipping unparsable: '${href}'."
      continue
    }

    $versionString = ${m}.Groups[1].Value
    try {
      $ver = [version]${versionString}
    } catch {
      Write-Verbose "Skipping prerelease/unparsable: '${versionString}'."
      continue
    }

    $twoPart = "$(${ver}.Major).$(${ver}.Minor)"
    if (${streams}.ContainsKey(${twoPart})) {
      continue
    }

    $streams[${twoPart}] = @{
      URL64   = $href
      Version = Get-FixVersion -Version ${versionString} -OnlyFixBelowVersion '2.5.4'
    }
  }

  Write-Verbose (${streams}.Count) 'streams collected.'
  return ${streams}
}

function global:au_GetLatest {
  [CmdletBinding()]
  param($releases)

  $webParams = @{
    Uri = ${releases}
    UseBasicParsing = $true
    ErrorAction = 'Stop'
  }
  try {
    $downloadPage = Invoke-WebRequest @webParams
  } catch {
    throw "Failed to fetch releases page: '$_'."
  }

  $releaseUrls = ${downloadPage}.Links | Where-Object {
    $_.href -and ($_.href -match '.exe') -and ($_.href -notmatch 'devkit')
  }
  return @{
    Streams = GetStreams -releaseUrls ${releaseUrls}
  }
}

if ($MyInvocation.InvocationName -ne '.') {
  # Run the update only if script is not sourced by the virtual package ruby.
  update -ChecksumFor none
}
