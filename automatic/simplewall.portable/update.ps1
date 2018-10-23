. $PSScriptRoot\..\simplewall\update.ps1

function global:au_BeforeUpdate {
    $Latest.URL32 = $Latest.URL32_p
    $Latest.FileType = 'zip'
    cp $PSScriptRoot\..\simplewall\README.md $PSScriptRoot\README.md
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
   @{
    ".\tools\chocolateyInstall.ps1" = @{
        "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
        }
    ".\legal\VERIFICATION.txt" = @{
        "(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
        "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        "(?i)(type:).*"       = "`${1} $($Latest.ChecksumType32)"
        }
    }
}

update -ChecksumFor none
