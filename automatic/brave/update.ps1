import-module au

$releases = 'https://github.com/brave/brave-browser/releases'

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url32     = $download_page.links | ? { $_.href -match 'StandaloneSilentSetup32.exe$' } | select -First 1 -expand href
    $url32_b   = $download_page.links | ? { $_.href -match 'SilentBetaSetup32.exe$' } | select -First 1 -expand href
    $url64     = $download_page.links | ? { $_.href -match 'StandaloneSilentSetup.exe$' } | select -First 1 -expand href
    $url64_b   = $download_page.links | ? { $_.href -match 'SilentBetaSetup.exe$' } | select -First 1 -expand href
    $version   = ($url32 -split '/' | select -Skip 1 -Last 1) -replace '^v',''
    $version_b = ($url32_b -split '/' | select -Skip 1 -Last 1) -replace '^v',''

    @{
        Streams = [ordered] @{
            'stable' = @{
                URL32   = 'https://github.com' + $url32
                URL64   = 'https://github.com' + $url64
                Version = $version
                Title   = 'Brave Browser'
                IconUrl = 'https://cdn.jsdelivr.net/gh/chocolatey/chocolatey-coreteampackages@a23ca30653/icons/brave.svg'
            }
           'beta' = @{
                URL32   = 'https://github.com' + $url32_b
                URL64   = 'https://github.com' + $url64_b
                Version = $version_b + '-beta'
                Title   = 'Brave Browser (Beta)'
                IconUrl = 'https://cdn.jsdelivr.net/gh/chocolatey/chocolatey-coreteampackages@a23ca30653/icons/brave-beta.svg'
           }
        }
    }
}

function global:au_BeforeUpdate {
  if ($Latest.Title -like '*Beta*') {
    cp "$PSScriptRoot\README-beta.md" "$PSScriptRoot\README.md" -Force
  } else {
    cp "$PSScriptRoot\README-release.md" "$PSScriptRoot\README.md" -Force
  }
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
   @{
        "tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName32)`""
            "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
        }
        "legal\VERIFICATION.txt" = @{
            "(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
            "(?i)(x86_64:).*"     = "`${1} $($Latest.URL64)"
            "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
            "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
        }
        "brave.nuspec" = @{
            "(\<title\>).*(\<\/title\>)"     = "`${1}$($Latest.Title)`$2"
            "(\<iconUrl\>).*(\<\/iconUrl\>)" = "`${1}$($Latest.IconUrl)`$2"
        }
    }
}

update -ChecksumFor none
