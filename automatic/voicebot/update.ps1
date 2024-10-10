﻿Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

function global:au_GetLatest {
    $downloadEndPointUrl = 'https://www.binaryfortress.com/Data/Download/?package=voicebot&log=123'
    $versionRegEx = 'VoiceBotSetup\-([0-9\.\-]+)([a-f])?\.exe'

    $downloadUrl = Get-RedirectedUrl $downloadEndPointUrl
    $versionMatch = $downloadUrl -match $versionRegEx

    if ($versionMatch) {
      if ($matches[2]) {
        $letterNum = [int]([char]$matches[2] - [char]'a')
        $version = $matches[1] + ".$letterNum"
      } else {
        $version = $matches[1]
      }
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

Update -ChecksumFor 32
