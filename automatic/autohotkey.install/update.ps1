Import-Module Chocolatey-AU

$releases = 'https://autohotkey.com/download/2.0'
$v1Version = '1.1.36.02'
$v1Filename = "AutoHotkey_$($v1Version)_setup.exe"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            '(?i)(^\s*\$installerv1File\s*=\s*)(''.*'')' = "`$1'$($Latest.v1FileName)'"
            '(?i)(^\s*\$installerv2File\s*=\s*)(''.*'')' = "`$1'$($Latest.FileName)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"      = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"         = "`$1'$($Latest.FileType)'"
        }

        ".\tools\verification.txt" = @{
          "(?i)(\s+v1 x32:).*"            = "`${1} $($Latest.v1URL)"
          "(?i)(v1 checksum32:).*"        = "`${1} $($Latest.v1Checksum)"
          "(?i)(\s+v2 x32:).*"            = "`${1} $($Latest.URL)"
          "(?i)(v2 checksum32:).*"        = "`${1} $($Latest.Checksum)"
          "(?i)(Get-RemoteChecksum).*"    = "`${1} $($Latest.URL)"
        }
    }
}

function global:au_BeforeUpdate {
    Remove-Item "$PSScriptRoot\tools\*.exe"

    $client = New-Object System.Net.WebClient
    $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"
    $client.DownloadFile($Latest.URL, $filePath)
    $client.Dispose()

    $Latest.ChecksumType = 'sha256'
    $Latest.Checksum = (Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath).Hash

    $client = New-Object System.Net.WebClient
    $filePath = "$PSScriptRoot\tools\$($Latest.v1FileName)"
    $client.DownloadFile($Latest.v1URL, $filePath)
    $client.Dispose()

    $Latest.v1ChecksumType = 'sha256'
    $Latest.v1Checksum = (Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath).Hash
}

function global:au_GetLatest {
    $version = Invoke-WebRequest -Uri "$releases\version.txt" -UseBasicParsing | ForEach-Object Content
    $url     = "https://github.com/AutoHotkey/AutoHotkey/releases/download/v$($version)/AutoHotkey_$($version)_setup.exe"
    @{
        Version  = $version
        URL      = $url
        FileName = "AutoHotkey_$($version)_setup.exe"
        v1Url    = "https://github.com/AutoHotkey/AutoHotkey/releases/download/v$($v1Version)/$v1Filename"
        v1FileName = $v1Filename
    }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none
}
