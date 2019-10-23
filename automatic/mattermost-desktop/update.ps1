import-module au

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt" = @{
      "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType64)"
      "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
      "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
      "(?i)(^\s*checksum\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {

  # Get latest published version
  $jsonAnswer = (Invoke-WebRequest -Uri "https://api.github.com/repos/mattermost/desktop/releases/latest" -UseBasicParsing).Content | ConvertFrom-Json

  $version = $jsonAnswer.tag_name -Replace '[^0-9.]'

  # Split the body description on line and takes likes with .msi with the next line as context
  $jsonAnswer.Body.Split("`n") | Select-String '\.msi' -Context 0,1 | ForEach-Object {
    # Sanitize string by spliting on spaces, and taking the longest
    # Example of unnsanitized string
    # > - https://releases.mattermost.com/desktop/4.3.0/mattermost-desktop-v4.3.0-x64.msi (beta)
    $msiUrl = ([string]$_).Split("`n")[0].Split(' ').where{ $_.length -gt 10 }.trim()
    ([string]$_).Split("`n")[1] -match '.*`(?<hash>.*)`.*' | Out-Null
    $digest = $matches['hash']

    if ($msiUrl -like '*x64*') {
      $msiUrl64 = $msiUrl
      $msiFilename64 = Split-Path -leaf $msiUrl
      $digest64 = $digest
    } else {
      $msiUrl32 = $msiUrl
      $msiFilename32 = Split-Path -leaf $msiUrl
      $digest32 = $digest
    }
  }

  return @{
    url32 = $msiUrl32;
    url64 = $msiUrl64;
    checksum32 = $digest32;
    checksum64 = $digest64;
    checksumType32 = 'SHA256';
    checksumType64 = 'SHA256';
    filename32 = $msiFilename32;
    filename64 = $msiFilename64;
    version = $version;
  }
}

update -ChecksumFor none
