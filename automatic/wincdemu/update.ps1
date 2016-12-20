import-module au

$releases = 'http://wincdemu.sysprogs.org/download'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = '\.exe'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = ($url -split '-' | select -Last 1).Replace('.exe','')

    @{ URL32 = $url; Version = $version }
}

$cert = ls cert: -Recurse | ? { $_.Thumbprint -eq '8880a2309be334678e3d912671f22049c5a49a78' }
if (!$cert) {
    Write-Host 'Adding program certificate: sysprogs.cer'
    certutil -addstore 'TrustedPublisher' "$PSScriptRoot\tools\sysprogs.cer"
}
update -ChecksumFor 32
