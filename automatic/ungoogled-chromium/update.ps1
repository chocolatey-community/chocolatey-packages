import-module au

$releases = 'https://github.com/ungoogled-software/ungoogled-chromium-windows/tags'

function global:au_SearchReplace {
   @{
		".\legal\VERIFICATION.txt" = @{
		  "(?i)(x86_64:).*"          = "`${1} $($Latest.URL64)"
		  "(?i)(checksum64:).*"      = "`${1} $($Latest.Checksum64)"
		}
        ".\tools\chocolateyinstall.ps1" = @{
            "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
        }
        "ungoogled-chromium.nuspec" = @{
          "(\<licenseUrl\>).*(\<\/licenseUrl\>)"     = "`${1}$($Latest.CopyingUrl)`$2"
          "(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ChangeLog)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $urlVersion = $download_page.links.href -match 'tag/' | Select -First 1 | % { $_ -split '/' | select -Last 1 }
    $version = $urlVersion.Substring(0,$urlVersion.Length-2)
    $version = $version.Replace('-','')

    @{
        Version        = $version
        URL64          = 'https://github.com/ungoogled-software/ungoogled-chromium-windows/releases/download/' + $urlVersion + '/ungoogled-chromium_' +  $urlVersion + '_windows_x64.zip'
        CopyingUrl = 'https://github.com/ungoogled-software/ungoogled-chromium-windows/blob/' + $urlVersion + '/LICENSE'
        ChangeLog  = 'https://github.com/ungoogled-software/ungoogled-chromium-windows/releases/' + $urlVersion
    }
}

function global:au_BeforeUpdate() {
    Get-RemoteFiles -Purge
}


try {
    update -checksumfor none
} catch  {
    if ($_ -match '404') { Write-Host "$_"; return 'ignore' }
}
