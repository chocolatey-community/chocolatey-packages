import-module au

$releases = 'https://rubyinstaller.org/downloads/archives/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            '(?i)(^\s*FileFullPath\s*=\s*)(.*)' = "`$1Join-Path `$toolsDir '$($Latest.FileName32)'"
            '(?i)(^\s*FileFullPath64\s*=\s*)(.*)' = "`$1Join-Path `$toolsDir '$($Latest.FileName64)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function GetStreams() {
  param($releaseUrls)
  $streams = @{ }
  
  $re64           = 'x64\.7z$'
  $x64releaseUrls = $releaseUrls | ? href -match $re64

  $x64releaseUrls | % {
    $version = $_ -replace '\-([\d]+)','.$1' -replace 'rubyinstaller.' -replace 'ruby.' -split '/' | select -Last 1 -Skip 1
    if ($version -match '[a-z]') { Write-Host "Skipping prerelease: '$version'"; return }
    $versionTwoPart = $version -replace '([\d]+\.[\d]+).*', "`$1"

    if ($streams.$versionTwoPart) { return }
    
    $url64 = $_ | Select-Object -ExpandProperty href
    $url32 = $releaseUrls | ? href -notmatch $re64 | ? href -match $version | Select-Object -ExpandProperty href
    
    if (!$url32 -or !$url64) {
      Write-Host "Skipping due to missing installer: '$version'"; return
    }

    $streams.$versionTwoPart = @{ URL32 = $url32 ; URL64 = $url64 ; Version = Get-FixVersion -Version $version -OnlyFixBelowVersion "2.5.4" }
  }

  Write-Host $streams.Count 'streams collected'
  $streams
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re            = '\.7z$'
    $releaseUrls   = $download_page.links | ? href -match $re | ? {$_ -notmatch 'doc'} 
    
    @{ Streams = GetStreams $releaseUrls }
}

if ($MyInvocation.InvocationName -ne '.') {
  # run the update only if script is not sourced by the virtual package ruby
  update -ChecksumFor none
}