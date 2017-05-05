Import-Module AU

function global:au_GetLatest {
    $releaseUrl = 'https://www.getpaint.net/index.html'
    $versionRegEx = 'paint\.net\s+([0-9\.]+)'
    $urlString = 'https://www.dotpdn.com/files/paint.net.$version.install.zip'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)
    $url = $ExecutionContext.InvokeCommand.ExpandString($urlString)

    return @{ Url32 = $url; Version = $version; }
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
