Import-Module AU

function global:au_BeforeUpdate {
    $Latest.ChecksumType32 = 'sha256'

    Get-RemoteFiles -Purge

    $file = Get-Item tools\*.exe | Select-Object -first 1
    Remove-Item $file -Force -ErrorAction SilentlyContinue
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]installer\s*=\s*)('.*')" = "`$1'$([System.IO.Path]::GetFileName($Latest.Url32))'"
            "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

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
        | Select-Object -Last 1

    $version = $versionInfo.Version

    if (!($version -match '\d+\.\d+')) {
        $version = "$($version).$($versionInfo.ReleaseDate)"
    }

    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update -ChecksumFor None
