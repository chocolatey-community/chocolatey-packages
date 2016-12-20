import-module au

$releases = 'https://autohotkey.com/download/1.1'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        ".\tools\verification.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL)"
        }
    }
}

function global:au_BeforeUpdate {
    rm "$PSScriptRoot\tools\*.exe"

    $client = New-Object System.Net.WebClient
        $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"
        $client.DownloadFile($Latest.URL, $filePath)
    $client.Dispose()

    $Latest.ChecksumType = 'sha256'
    $Latest.Checksum = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath | % Hash
}

function global:au_GetLatest {
    $version = Invoke-WebRequest -Uri "$releases\version.txt" -UseBasicParsing | % Content
    $url     = "https://github.com/Lexikos/AutoHotkey_L/releases/download/v${version}/AutoHotkey_${version}_setup.exe"
    @{
        Version  = $version
        URL      = $url
        FileName = $url -split '/' | select -Last 1
    }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none
}
