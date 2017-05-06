. "$PSScriptRoot\..\7zip\update.ps1"
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$softwareNamePrefix = '7-zip'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameBase '7zip' }

function global:au_AfterUpdate {
  Update-ChangelogVersion -Version $Latest.Version
}

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt" = @{
      "(?i)(listed on\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:).*" = "`${1} $($Latest.ChecksumType)"
      "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
      "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
    }
  }
}

update -ChecksumFor none
