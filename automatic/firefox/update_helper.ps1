import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"
$localeChecksumFile = 'LanguageChecksums.csv'

function GetMozillaUrlFormats() {
  # Builds the per-architecture download URL formats from a base 'os=win' URL
  # (with the version baked in and ${locale} left as a placeholder). Shared by
  # the Firefox and Thunderbird update scripts.
  param(
    [Parameter(Mandatory = $true)]
    [string]$Url,
    [Parameter(Mandatory = $true)]
    [string]$Version,
    [bool]$Supports64Bit = $true
  )

  $result = @{
    Version     = $Version
    Win32Format = $Url -replace 'latest', $Version
  }

  if ($Supports64Bit) {
    $result += @{
      Win64Format      = $Url -replace 'os=win', 'os=win64' -replace 'latest', $Version
      Win64Arm64Format = $Url -replace 'os=win', 'os=win64-aarch64' -replace 'latest', $Version
    }
  }
  return $result
}

function GetVersionAndUrlFormats() {
  param(
    [string]$UpdateUrl,
    [string]$Product,
    [bool]$Supports64Bit = $true
  )

  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $UpdateUrl

  $re = "download.mozilla.*product=$Product.*(&amp;|&)os=win(&amp;|&)lang=en-US"
  $url = $download_page.links | Where-Object href -match $re | Where-Object href -NotMatch 'stub|next' | Select-Object -first 1 -expand href
  $redirectedUrl = Get-RedirectedUrl $url
  $url = $url -replace 'en-US', '${locale}' -replace '&amp;', '&'
  $version = $redirectedUrl -split '\/' | Select-Object -Last 1 -Skip 3
  if ($version.EndsWith('esr')) {
    $version = $version.TrimEnd('esr')
    $url = $url -replace 'esr-latest', "${version}esr"
  }

  return GetMozillaUrlFormats -Url $url -Version $version -Supports64Bit $Supports64Bit
}

function CreateChecksumsFile() {
  param(
    [string]$ToolsDirectory,
    [string]$ExecutableName,
    [string]$Version,
    [string]$Product,
    [switch]$ExtendedRelease
  )
  if ($ExtendedRelease) {
    $allChecksums = Invoke-WebRequest -UseBasicParsing -Uri "https://releases.mozilla.org/pub/$Product/releases/${Version}esr/SHA512SUMS"
  }
  else {
    $allChecksums = Invoke-WebRequest -UseBasicParsing -Uri "https://releases.mozilla.org/pub/$Product/releases/$Version/SHA512SUMS"
  }

  $reOpts = [System.Text.RegularExpressions.RegexOptions]::Multiline `
    -bor [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
  # 'win64-aarch64' is listed first so the alternation prefers it over 'win64'.
  $checksumRows = [regex]::Matches("$allChecksums", "^(?:b')?([a-f\d]+)'?\s*win(64-aarch64|64|32)\/([a-z\-]+)\/$ExecutableName\s*$", $reOpts) | ForEach-Object {
    return "$($_.Groups[3].Value)|$($_.Groups[2].Value)|$($_.Groups[1].Value)"
  }

  if (!$checksumRows) {
    throw "Unable to extract any valid checksums, please look into the reason. A upstream change may be the cause..."
  }

  $checksumRows | Out-File "$ToolsDirectory\$localeChecksumFile" -Encoding utf8
}

function SearchAndReplace() {
  param(
    [string]$PackageDirectory,
    [hashtable]$Data,
    [bool]$Supports64Bit = $true
  )

  # The download URLs are matched on their "os" token so each architecture's
  # literal in the $builds map is updated independently. The token boundaries
  # ('os=win&' vs 'os=win64&' vs 'os=win64-aarch64&') keep the patterns from
  # overlapping.
  $installReplacements = @{
    "(?i)(^[$]packageName\s*=\s*)('.*')"      = "`$1'$($Data.PackageName)'"
    "(?i)(^[$]softwareName\s*=\s*)('.*')"     = "`$1'$($Data.SoftwareName)'"
    "(?i)(-version\s*)('.*')"                 = "`$1'$($Data.RemoteVersion)'"
    '(?i)"[^"]*[?&]os=win&[^"]*"'             = "`"$($Data.Win32Format)`""
    '(?i)(\s*\-(checksum|locale)File\s*)".*"' = "`$1`"`$toolsPath\$localeChecksumFile`""
  }

  if ($Supports64Bit) {
    $installReplacements += @{
      '(?i)"[^"]*[?&]os=win64&[^"]*"'         = "`"$($Data.Win64Format)`""
      '(?i)"[^"]*[?&]os=win64-aarch64&[^"]*"' = "`"$($Data.Win64Arm64Format)`""
    }
  }

  $result = @{
    "$PackageDirectory\tools\chocolateyInstall.ps1"   = $installReplacements
    "$PackageDirectory\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)('.*')" = "`$1'$($Data.PackageName)'"
      "(?i)(-SoftwareName\s*)('.*')"       = "`$1'$($Data.SoftwareName)*'"
    }
  }

  if ($Data.ReleaseNotes) {
    $nuspecReplacements = @{
      "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Data.ReleaseNotes)`${2}"
    }
  }

  if ($Data.PackageTitle) {
    $nuspecReplacements += @{
      "(?i)(\<title\>).*(\<\/title\>)" = "`${1}$($Data.PackageTitle)`${2}"
    }
  }
  
  if (($Data.ReleaseNotes) -or ($Data.PackageTitle)) {
    $result += @{
      "$PackageDirectory\*.nuspec" = $nuspecReplacements
    }
  }

  $result
}
