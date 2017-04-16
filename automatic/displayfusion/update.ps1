Import-Module AU

function global:au_GetLatest {
    $downloadEndPointUrl = 'https://www.binaryfortress.com/Data/Download/?package=displayfusion&log=101'
    $versionRegEx = 'DisplayFusionSetup-([0-9\.\-]+)\.exe'

    $downloadUrl = ((Get-WebURL -Url $downloadEndPointUrl).ResponseUri).AbsoluteUri
    $version = $downloadUrl -match $versionRegEx

    if ($matches) {
        $version = $matches[1]
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update -ChecksumFor 32
