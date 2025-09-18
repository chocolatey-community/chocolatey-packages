Import-Module Chocolatey-AU

$releases = "https://www.autoitscript.com/site/autoit/downloads"

function global:au_BeforeUpdate {
    Remove-Item "$PSScriptRoot\tools\*.exe"

    $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"
    Invoke-WebRequest $Latest.URL32 -OutFile $filePath

    $Latest.ChecksumType = "sha256"
    $Latest.Checksum = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath | ForEach-Object Hash
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]filePath\s*=\s*`"[$]toolsDir\\)(.*)`"" = "`$1$($Latest.FileName)`""
        }
        ".\tools\verification.txt" = @{
            "(?i)(1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType)"
            "(?i)(checksum:\s+).*" = "`${1}$($Latest.Checksum)"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $download_page.RawContent -match '>Latest Version:.+\W?v(?<Version>[\d]+\.[\d\.]+)<' | Out-Null
    $version = $Matches.Version

    $url = $download_page.links.href.Where{"$_".EndsWith('.zip') -and $_ -notmatch '-setup'}

    $filename = $url -split '/' | Select-Object -Last 1

    return @{
        URL32 = "https://www.autoitscript.com" + $url
        FileName = $filename
        Version = $version
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none -NoCheckUrl
}
