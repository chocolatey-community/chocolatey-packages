import-module au

$releases = 'https://sourceforge.net/projects/filezilla/files/FileZilla_Client'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameSkip 1}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version  =  $download_page.Links.href | ? { $_ } | % { $x=Split-Path -Leaf $_;  if ([Version]::TryParse($x, [ref]($__))) { $x } } | select -First 1
    @{
        Version = $version
        URL64   = "https://sourceforge.net/projects/filezilla/files/FileZilla_Client/$version/FileZilla_${version}_win64-setup.exe/download"
        URL32   = "https://sourceforge.net/projects/filezilla/files/FileZilla_Client/$version/FileZilla_${version}_win32-setup.exe/download"
        FileType = 'exe'
    }
}

update -ChecksumFor none
