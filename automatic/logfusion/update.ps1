﻿Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

function global:au_GetLatest {
    $downloadEndPointUrl = 'https://www.binaryfortress.com/Data/Download/?package=logfusion&log=117'
    $versionRegEx = 'LogFusionSetup-([0-9\.\-]+)[a-z]?\.exe'

    $downloadUrl = Get-RedirectedUrl $downloadEndPointUrl
    $versionInfo = $downloadUrl -match $versionRegEx

    if ($versionInfo) {
        $version = $matches[1]
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

Update  -ChecksumFor 32
