Import-Module AU

function global:au_GetLatest {
    $productName = 'DataGrip'
    $releaseUrl = 'https://www.jetbrains.com/updates/updates.xml'
    $downloadUrl = 'https://download.jetbrains.com/datagrip/datagrip-$($version).exe'

    [xml] $updates = (New-Object System.Net.WebClient).DownloadString($releaseUrl)
    $channels = $updates.products.product | ? name -eq $productName | select -expand channel
    $build = $channels | ? status -eq 'release' | select -expand build
    $versionInfo = $build `
        | Sort-Object { [version] $_.fullNumber } `
        | Where-Object { $_.version -notmatch 'EAP' } `
        | Select-Object -Last 1

    $version = $versionInfo.Version

    if (!($version -match '\d+\.\d+')) {
        $version = "$($version).$($versionInfo.ReleaseDate)"
    }

    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

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
