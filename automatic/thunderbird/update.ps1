[CmdletBinding()]
param($IncludeStream, [switch] $Force)
Import-Module Chocolatey-AU
. "$PSScriptRoot\..\Firefox\update_helper.ps1"

$releases = 'https://www.thunderbird.net/en-US/thunderbird/all/'
$releasesESR = 'https://www.thunderbird.net/en-US/thunderbird/all/?release=esr'
$product  = 'thunderbird'

function GetThunderBirdVersionAndUrlFormats() {
  param(
    [string]$baseUrl,
    [string]$Product,
    [bool]$Supports64Bit = $true
  )

  $latestUrl32 = $baseUrl + "?product=" + $product + "-latest&os=win&lang=en-US"
  $redirectedUrl = Get-RedirectedUrl $latestUrl32
 
  $url = $latestUrl32 -replace 'en-US', '${locale}' -replace '&amp;', '&'
  $version = $redirectedUrl -split '\/' | Select-Object -Last 1 -Skip 3
  if ($version.EndsWith('esr')) {
    $version = $version.TrimEnd('esr')
    $url = $url -replace 'esr-latest', "${version}esr"
  }

  $result = @{
    Version     = $version
    Win32Format = $url -replace 'latest', $version
  }

  if ($Supports64Bit) {
    $result += @{
      Win64Format = $url -replace 'os=win', 'os=win64' -replace 'win32', 'win64' -replace 'latest', $version
    }
  }
  return $result
}

function global:au_BeforeUpdate {
  Copy-Item "$PSScriptRoot\Readme.$($Latest.PackageName).md" "$PSScriptRoot\README.md" -Force
}

function global:au_AfterUpdate {
  $version = $Latest.RemoteVersion
  CreateChecksumsFile -ToolsDirectory "$PSScriptRoot\tools" `
    -ExecutableName $Latest.ExeName `
    -Version $version `
    -Product $product `
    -ExtendedRelease:$($Latest.PackageName -eq 'thunderbirdesr')
}

function global:au_SearchReplace {
  $version = $Latest.RemoteVersion

  SearchAndReplace -PackageDirectory "$PSScriptRoot" `
    -Data $Latest
}

function global:au_GetLatest {
  $streams = @{}
  
  $data  = GetThunderBirdVersionAndUrlFormats -baseUrl "https://download.mozilla.org/" -Product "${product}"
  $version = $data.Version

  $streams.Add("latest", @{
    LocaleURL = "$releases"
    Version = $data.Version
    RemoteVersion = $data.Version
    Win32Format = $data.Win32Format
    Win64Format = $data.Win64Format
    SoftwareName = 'Mozilla Thunderbird'
    ReleaseNotes  = "https://www.thunderbird.net/en-US/thunderbird/${version}/releasenotes/"
    PackageName   = 'thunderbird'
    ExeName       = "Thunderbird Setup $($version).exe"
    PackageTitle  = 'Thunderbird (Release)'
    })

  $data = GetThunderBirdVersionAndUrlFormats -baseUrl "https://download.mozilla.org/" -Product "${product}-esr"
  $version = $data.Version

  $streams.Add('esr', @{
    LocaleURL = "$releasesESR"
    Version = $data.Version
    RemoteVersion = $data.Version
    Win32Format = $data.Win32Format
    Win64Format = $data.Win64Format
    SoftwareName = 'Mozilla Thunderbird'
    ReleaseNotes  = "https://www.thunderbird.net/en-US/thunderbird/${version}esr/releaseNotes/"
    ExeName       = "Thunderbird Setup $($version)esr.exe"
    PackageName   = 'thunderbirdesr'
    PackageTitle  = 'Thunderbird (ESR)'
    })

  return @{ Streams = $streams }
}

update -ChecksumFor none
