Import-Module Chocolatey-AU

$releases = 'https://filezilla-project.org/download.php?show_all=1'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($releases)"
          "(?i)(\s+x64:).*"            = "`${1} $($releases)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameBase "FileZilla_$($Latest.Version)"}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing -UserAgent "Chocolatey"
    $url32 = $download_page.Links | Where-Object href -match "win32\-setup\.exe" | Select-Object -first 1 -expand href
    $url64 = $download_page.Links | Where-Object href -match "win64\-setup\.exe" | Select-Object -first 1 -expand href
    $version = $url32 -split '_' | Where-Object { $_ -match '^\d+\.[\d\.]+$' } | Select-Object -first 1

    @{
        Version  = $version
        URL64    = $url64
        URL32    = $url32
        FileType = "exe"
    }
}

update -ChecksumFor none
