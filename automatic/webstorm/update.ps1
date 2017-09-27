Import-Module AU

function global:au_GetLatest {
    $productName = 'WebStorm'
    $releaseUrl = 'https://www.jetbrains.com/updates/updates.xml'
    $downloadUrl = 'https://download.jetbrains.com/webstorm/WebStorm-$($version).exe'

    [xml] $updates = (New-Object System.Net.WebClient).DownloadString($releaseUrl)
    $versionInfo = $updates.products.product `
        | Where-Object { $_.name -eq $productName } `
        | ForEach-Object { $_.channel } | Where-Object { $_.id -eq 'WS_Release' } `
        | ForEach-Object { $_.build } `
        | Sort-Object { [version] $_.number } `
        | Where-Object { $_.version -notmatch 'EAP' } `
        | Select-Object -Last 1

    $version = $versionInfo.Version

    if (!($version -match '\d+\.\d+')) {
        $version = "$($version).$($versionInfo.ReleaseDate)"
    }

    # Expands the URL into https://download.jetbrains.com/webstorm/WebStorm-2017.1.3.exe
    $url = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    return @{ Url32 = $url; Version = $version }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

Update -ChecksumFor 32
