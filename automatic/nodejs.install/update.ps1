[CmdletBinding()]
param($IncludeStream, [switch] $Force)

Import-Module Chocolatey-AU

if ($MyInvocation.InvocationName -ne '.') {
  # run the update only if the script is not sourced
  function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge

    if ($Latest.URL32) {
      Copy-Item "$PSScriptRoot\legal\VERIFICATION.full.txt" "$PSScriptRoot\legal\VERIFICATION.txt" -Force
    }
    else {
      Copy-Item "$PSScriptRoot\legal\VERIFICATION.x64.txt" "$PSScriptRoot\legal\VERIFICATION.txt" -Force
    }
  }
}

function global:au_SearchReplace {
  $version = [version]$Latest.Version
  $silentArgs = if ($version -lt [version]'11.0') {
    ' REMOVE=NodeEtwSupport,NodePerfCtrSupport'
  }
  $silentArgs = "/quiet ADDLOCAL=ALL${silentArgs}"

  $verificationReplacements = @{
    "(?i)(64-Bit:).*"                  = "`$1 <$($Latest.URL64)>"
    "(?i)(the following).*(checksum:)" = "`${1} $($Latest.ChecksumType64.ToUpper()) `$2"
    "(?i)(64-Bit Checksum:).*"         = "`$1 <$($Latest.Checksum64)>"
  }

  if ($Latest.URL32) {
    $verificationReplacements['(?i)(32-Bit:).*'] = "`${1} <$($Latest.URL32)>"
    $verificationReplacements['(?i)(32-Bit Checksum:).*'] = "`${1} <$($Latest.Checksum32)>"
  }

  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(\s*file\s*=\s*)[`"']([$]toolsPath\\)?.*"= if ($Latest.FileName32) { "`${1}`"`$toolsPath\$($Latest.FileName32)`"" } else { "`${1}''" }
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName64)`""
      "(?i)(^\s*SilentArgs\s*=\s*)'.*'"             = "`${1}'$silentArgs'"
    }
    ".\legal\verification.txt"      = $verificationReplacements
  }
}

function global:au_GetLatest {
  $scheduleUri = 'https://raw.githubusercontent.com/nodejs/Release/main/schedule.json'
  $schedules = Invoke-RestMethod -Uri $scheduleUri -UseBasicParsing

  $curDate = (Get-Date).Date
  $supportedChannels = @()
  $schedules.PSObject.Properties.Name | ForEach-Object {
    $name = $_
    $schedule = $schedules.$name
    $scheduleStart = [datetime]$schedule.start
    $scheduleEnd = [datetime]$schedule.end
    if (($scheduleStart -le $curDate) -and ($scheduleEnd -ge $curDate)) {
      $supportedChannels += $name
    }
  }

  $versionsUri = 'https://nodejs.org/dist/index.json'
  $versions = Invoke-RestMethod -Uri $versionsUri -UseBasicParsing

  $streams = @{ }

  $supportedChannels | ForEach-Object {
    $channel = $_
    $latestVersion = $versions | Where-Object -FilterScript { $_.version.StartsWith($channel) } | Select-Object -First 1
    $version = $latestVersion.version
    $versionStrict = [version]::Parse($latestVersion.version.Substring(1))
    if ($streams.ContainsKey($versionStrict.Major.ToString())) { return ; }

    $url32 = "https://nodejs.org/dist/$version/node-$version-x86.msi"
    $url64 = "https://nodejs.org/dist/$version/node-$version-x64.msi"

    $streamData = @{
      Version = $versionStrict.ToString()
      URL64   = $url64
    }

    if ($versionStrict.Major -lt 23) {
      $streamData['URL32'] = $url32
    }

    $streams.Add($versionStrict.Major.ToString(), $streamData)
  }

  return @{ Streams = $streams }
}

if ($MyInvocation.InvocationName -ne '.') {
  # run the update only if script is not sourced
  update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
}
