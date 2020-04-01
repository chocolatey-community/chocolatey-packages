import-module au

$releases = 'https://www.waterfox.net/releases/'
$softwareName = 'Waterfox*'

function global:au_BeforeUpdate {
  if ($Latest.Title -like '*Classic*') {
    cp "$PSScriptRoot\readme.classic.md" "$PSScriptRoot\readme.md" -Force
  }
  else {
    cp "$PSScriptRoot\readme.current.md" "$PSScriptRoot\readme.md" -Force
  }
  
  $Latest.ChecksumType64 = 'sha256'
  $fileName = $Latest.URL64 -split '/' | select -last 1
  $fileName = ($fileName -replace '%20',' ').TrimEnd('.exe')
  Get-RemoteFiles -Purge -FileNameBase $fileName
  $Latest.FileName64 = $fileName + "_x64.exe"
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(listed on\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(1\..+)\<.*\>"        = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType64)"
      "(?i)(checksum:).*"        = "`${1} $($Latest.Checksum64)"
    }

    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(`"`[$]toolsDir\\).*`""        = "`${1}$($Latest.FileName64)`""
      "(?i)(^\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
    }
    ".\waterfox.nuspec"  = @{
      "(?i)(^\s*\<title\>).*(\<\/title\>)" = "`${1}$($Latest.Title)`${2}"
    }
  }
}

function Get-Waterfox {
param(
    [string]$build
)
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re    = "(?:Waterfox%20$build%20)([\d]{0,4}[\.][\d]{0,2})(%20Setup\.[ex]+)|(?:Waterfox%20$build%20)([\d]{0,4}[\.][\d]{0,2}[\.][\d]{0,2})(%20Setup\.[ex]+)"
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href
  if (!$url) {
    $re = 'Setup\.exe$' # If we didn't get a url with the previous regex, we use a much simpler way
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
  }

  $version  = $url -split '%20| ' | select -Last 1 -Skip 1
  if ($build -eq 'Classic') { $build = 'classic'; $dash = '-' } else { $build=$dash = '' }
	$namePackage = @{$true="waterfox$dash$build";$false="Waterfox$dash$build"}[ ($build -eq 'Classic') ]
  # We need to replace the space in the url, otherwise we'll get an invalid url error.
  return @{ PackageName = $namePackage ; Title = "Waterfox $build" ; URL64 = ($url -replace ' ','%20'); Version = $version }
}

function global:au_GetLatest {

  $streams = [ordered] @{
    classic = Get-Waterfox -build "Classic"
    current = Get-Waterfox -build "Current"
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none
