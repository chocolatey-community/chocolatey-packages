Import-Module Chocolatey-AU

$releases = 'https://sqlite.org/download.html'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(\s+Toolsx64:).*"       = "`${1} $($Latest.URLTools64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(checksumTools64:).*"   = "`${1} $($Latest.ChecksumTools64)"
        }
        ".\tools\chocolateyInstall.ps1" = @{
          "sqlite-dll-win-x86.+\.zip" = "$($Latest.Filename32)"
          "sqlite-dll-win-x64.+\.zip" = "$($Latest.Filename64)"
          "sqlite-tools-win-x.+\.zip" = "$($Latest.FilenameTools64)"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
    $tools_name = $Latest.URLTools64 -split '/' | Select-Object -Last 1
    Invoke-WebRequest $Latest.URLTools64 -OutFile tools\$tools_name
    $Latest.FilenameTools64 = $tools_name
    $Latest.ChecksumTools64 = Get-FileHash tools\$tools_name | ForEach-Object Hash
}

function global:au_GetLatest {

  function Get-SqliteWindowsDownload {
    [CmdletBinding()]
    param(
      [Parameter(Mandatory)]
      [string]$Uri
    )

    $html = (Invoke-WebRequest -Uri $Uri -UseBasicParsing).Content

    # Pull the CSV from the special HTML comment block
    $pattern = '(?s)<!--\s*Download product data for scripts to read\s*(?<csv>PRODUCT,VERSION,RELATIVE-URL,SIZE-IN-BYTES,SHA3-HASH.*?)(?:\r?\n)?\s*-->'
    $m = [regex]::Match($html, $pattern)
    if (-not $m.Success) {
      throw "Could not find the 'Download product data for scripts to read' block."
    }

    $rows = ($m.Groups['csv'].Value.Trim()) | ConvertFrom-Csv
    $baseUri = [Uri]$Uri

    $winItems = foreach ($row in $rows) {
      $rel = $row.'RELATIVE-URL'
      $file = Split-Path -Leaf $rel

      # Keep Windows-only artifacts
      if ($file -notmatch '-win-') { continue }

      # Artifact: dll | tools | win (e.g., sqlite-win-arm64ec-...)
      $artifact = if ($file -match '^sqlite-(dll|tools|win)-') { $Matches[1] } else { $null }

      # Architecture: prefer specific matches first
      $architecture = switch -regex ($file) {
        '-x64-' { 'x64'; break }
        '-x86-' { 'x86'; break }
        default { $null }
      }

      if (!$architecture) {
        continue;
      }

      [pscustomobject]@{
        Version      = $row.VERSION
        RelativeUrl  = $rel
        Url          = ([Uri]::new($baseUri, $rel)).AbsoluteUri
        Artifact     = $artifact
        Architecture = $architecture
      }
    }

    if (-not $winItems) {
      return
    }

    # Group by Version → return { Version, Downloads = [...] }
    $winItems |
    Group-Object Version |
    Sort-Object Name -Descending |
    ForEach-Object {
      [pscustomobject]@{
        Version   = $_.Name
        Downloads = $_.Group | Sort-Object Artifact, Architecture, Url
      }
    }
  }

  [array]$groupedItems = Get-SqliteWindowsDownload -Uri $releases

  if (!$groupedItems) {
    throw "We were not able to get any artifacts we were interested in."
  }
  # We should only have a single item, we do not support streams.
  elseif ($groupedItems.Count -ne 1) {
    throw "We got different number of versions that we were expecting. We received $($groupedItems.Count) versions."
  }

  $url32 = $groupedItems.Downloads | Where-Object { $_.Artifact -eq 'dll' -and $_.Architecture -eq 'x86' }
  $url64 = $groupedItems.Downloads | Where-Object { $_.Artifact -eq 'dll' -and $_.Architecture -eq 'x64' }
  $urlTools64 = $groupedItems.Downloads | Where-Object { $_.Artifact -eq 'tools' -and $_.Architecture -eq 'x64' }

  @{
    Version     = $groupedItems.Version
    URL32       = $url32.Url
    URL64       = $url64.Url
    URLTools64  = $urlTools64.Url
    PackageName = 'SQLite'
  }
}

update -ChecksumFor none
