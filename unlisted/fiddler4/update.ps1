import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $url        = ''
    $setup_path = "$PSScriptRoot\fiddlersetup.exe"

    Write-Host "Downloading full setup file to find the version"
    iwr $url -OutFile $setup_path
    $version = gi $setup_path | % { [System.Diagnostics.FileVersionInfo]::GetVersionInfo($_).FileVersion }
    $checksum32 = Get-FileHash $setup_path | % Hash
    rm fiddlersetup.exe -ea 0
    @{
        Version    = $version
        URL32      = $url
        Checksum32 = $checksum32
    }
}

update -NoCheckUrl -ChecksumFor none
