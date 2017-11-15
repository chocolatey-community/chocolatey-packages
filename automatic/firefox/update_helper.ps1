import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"
$localeChecksumFile = 'LanguageChecksums.csv'

function GetVersionAndUrlFormats() {
  param(
    [string]$UpdateUrl,
    [string]$Product,
    [bool]$Supports64Bit = $true
  )

  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $UpdateUrl

  $re = "download.mozilla.*product=$Product.*&amp;os=win&amp;lang=en-US"
  $url = $download_page.links | ? href -match $re | select -first 1 -expand href
  $url = Get-RedirectedUrl $url
  $url = $url -replace 'en-US','${locale}' -replace '&amp;','&'

  $result = @{
    Version = $url -split '\/' | select -last 1 -skip 3
    Win32Format = $url
  }
  if ($result.Version.EndsWith('esr')) {
    $result.Version = $result.Version.TrimEnd('esr')
  }
  if ($Supports64Bit) {
    $result += @{
      Win64Format = $url -replace 'os=win','os=win64' -replace 'win32','win64'
    }
  }
  return $result
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
  } else {
    $allChecksums = Invoke-WebRequest -UseBasicParsing -Uri "https://releases.mozilla.org/pub/$Product/releases/$Version/SHA512SUMS"
  }

  $reOpts = [System.Text.RegularExpressions.RegexOptions]::Multiline `
    -bor [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
  $checksumRows = [regex]::Matches("$allChecksums", "^([a-f\d]+)\s*win(32|64)\/([a-z\-]+)\/$ExecutableName$", $reOpts) | % {
    return "$($_.Groups[3].Value)|$($_.Groups[2].Value)|$($_.Groups[1].Value)"
  }

  $checksumRows | Out-File "$ToolsDirectory\$localeChecksumFile" -Encoding utf8
}

function SearchAndReplace() {
  param(
    [string]$PackageDirectory,
    [hashtable]$Data,
    [bool]$Supports64Bit = $true
  )

  $installReplacements = @{
    "(?i)(^[$]packageName\s*=\s*)('.*')"      = "`$1'$($Data.PackageName)'"
    "(?i)(^[$]softwareName\s*=\s*)('.*')"     = "`$1'$($Data.SoftwareName)'"
    "(?i)(-version\s*)('.*')"                 = "`$1'$($Data.RemoteVersion)'"
    '(?i)(\s*Url\s*=\s*)(".*")'               = "`$1`"$($Data.Win32Format)`""
    '(?i)(\s*\-(checksum|locale)File\s*)".*"' = "`$1`"`$toolsPath\$localeChecksumFile`""
  }

  if ($Supports64Bit) {
    $installReplacements += @{
    '(?i)(\.Url64\s*=\s*)(".*")'              = "`$1`"$($Data.Win64Format)`""
    }
  }

  $result = @{
    "$PackageDirectory\tools\chocolateyInstall.ps1" = $installReplacements
    "$PackageDirectory\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)('.*')"      = "`$1'$($Data.PackageName)'"
      "(?i)(-SoftwareName\s*)('.*')"            = "`$1'$($Data.SoftwareName)*'"
    }
  }

  if ($Latest.ReleaseNotes) {
    $result += @{
      "$PackageDirectory\$($Latest.PackageName).nuspec" = @{
        "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
      }
    }
  }

  $result
}
