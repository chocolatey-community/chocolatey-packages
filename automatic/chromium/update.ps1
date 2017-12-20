
import-module au

function global:au_SearchReplace {
   @{
    ".\legal\verification.txt" = @{
        "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
        "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
        "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
        "(?i)(^\s*checksum32\:).*"          = "`${1} $($Latest.Checksum32)"
        "(?i)(^\s*checksum64\:).*"          = "`${1} $($Latest.Checksum64)"
        }
    ".\tools\chocolateyInstall.ps1" = @{
        '(^[$]version\s*=\s*)(".*")' = "`$1""$($Latest.Version)"""
        '(?i)(^\s*file\s*=\s*)(".*")' = "`$1""$($Latest.PackageName32)"""
        '(?i)(^\s*file64\s*=\s*)(".*")' = "`$1""$($Latest.PackageName64)"""
        }
    ".\chromium.nuspec" = @{
      "(?i)(^\s*\<title\>).*(\<\/title\>)" = "`${1}$($Latest.Title)`${2}"
    }
    }
}

function global:au_BeforeUpdate {
  # Copy the original file from the chromium folder
    Get-RemoteFiles -Purge -FileNameBase "$($Latest.PackageName)"
}

    $releases_stable = 'https://api.github.com/repos/henrypp/chromium/releases'
    $releases_snapshots = 'https://chromium.woolyss.com/api/v2/?os=windows&bit=<bit>&out=string'
    $PackageName = 'chromium'
    $ChecksumType = 'sha256'
    $PackageName32 = ("`$toolsdir\"+($PackageName)+"_x32.exe");
    $PackageName64 = ("`$toolsdir\"+($PackageName)+"_x64.exe");
    
function Get-Snapshots {
param(
	[string]$releases,
	[string]$Title
)

    $releases_x32 = $releases -replace('<bit>','32')
    $releases_x64 = $releases -replace('<bit>','64')
    $download_page32 = Invoke-WebRequest -Uri $releases_x32
    $download_page64 = Invoke-WebRequest -Uri $releases_x64

    $val32 = $download_page32 -split ";"
    $val64 = $download_page64 -split ";"

    $chromium32 = $val32 | out-string | ConvertFrom-StringData
    $chromium64 = $val64 | out-string | ConvertFrom-StringData

    $version = $chromium32.version + "-snapshots"
    $Pre_Url = 'https://storage.googleapis.com/chromium-browser-snapshots/'
    $url32 = $Pre_Url+"Win/<revision>/mini_installer.exe"
    $url64 = $Pre_Url+"Win_x64/<revision>/mini_installer.exe"
    $url32 = $url32 -replace '<revision>', $chromium32.revision
    $url64 = $url64 -replace '<revision>', $chromium64.revision
    
    @{
        URL32 = $url32
        URL64 = $url64
        Version = $version
        PackageName = $PackageName
        Title = $Title
        PackageName32 = $PackageName32
        PackageName64 = $PackageName64
        ChecksumType32 = $ChecksumType
        ChecksumType64 = $ChecksumType
    }
}

function Get-Stable {
param(
	[string]$releases,
	[string]$Title
)

  $allVersions = Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json
  $allStableVersions = $allVersions | Where-Object {$_.body -match "stable" -and $_.body -match "windows x86 and x64"}
  $latestStableVersionNumber = ($allStableVersions[0].tag_name.split('-') | Select-Object -First 1) -replace 'v', ''
  $anyArchLatestStablesVersions = $allVersions  | Where-Object {$_.tag_name -match $latestStableVersionNumber}

  $32LatestVersion = $anyArchLatestStablesVersions | Where-Object {$_.tag_name -match $latestStableVersionNumber -and $_.tag_name -match "win32"}
  $32LatestSyncInstallUrl = ($32LatestVersion.assets | Where-Object name -match "-sync.exe").browser_download_url

  $64LatestVersion = $anyArchLatestStablesVersions | Where-Object {$_.tag_name -match $latestStableVersionNumber -and $_.tag_name -match "win64"}
  $64LatestSyncInstallUrl = ($64LatestVersion.assets | Where-Object name -match "-sync.exe").browser_download_url

  @{
    Version = $latestStableVersionNumber
    PackageName = $PackageName
    Title = $Title
	PackageName32 = $PackageName32
    URL32 = $32LatestSyncInstallUrl
    ChecksumType32 = $ChecksumType
	PackageName64 = $PackageName64
    URL64 = $64LatestSyncInstallUrl
    ChecksumType64 = $ChecksumType
  }

}

function global:au_GetLatest {
  $streams = [ordered] @{
    stable = Get-Stable -releases $releases_stable -Title "Chromium"
    snapshots = Get-Snapshots -releases $releases_snapshots -Title "Chromium Snapshots"
  }

  return @{ Streams = $streams }
}


update -ChecksumFor none
