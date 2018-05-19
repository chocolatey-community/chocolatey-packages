[CmdletBinding()]
param($IncludeStream, [switch] $Force)
import-module au
. "$PSScriptRoot\update_helper.ps1"

$releases = 'https://www.mozilla.org/en-US/firefox/all/'
$releasesESR = 'https://www.mozilla.org/en-US/firefox/organizations/all/'
$product = 'firefox'

function global:au_BeforeUpdate {
  cp "$PSScriptRoot\Readme.$($Latest.PackageName).md" "$PSScriptRoot\README.md" -Force
}

function global:au_AfterUpdate {
  CreateChecksumsFile -ToolsDirectory "$PSScriptRoot\tools" `
    -ExecutableName $Latest.ExeName `
    -Version $Latest.RemoteVersion `
    -Product $product `
    -ExtendedRelease:$($Latest.PackageName -eq 'FirefoxESR')
}

function global:au_SearchReplace {
  SearchAndReplace -PackageDirectory "$PSScriptRoot" `
    -Data $Latest
}

function global:au_GetLatest {
  $data = GetVersionAndUrlFormats -UpdateUrl $releases -Product $product
  $version = $data.Version

  $streams = @{}

  $streams.Add("latest", @{
      LocaleURL     = "$releases"
      Version       = $version
      RemoteVersion = $version
      Win32Format   = $data.Win32Format
      Win64Format   = $data.Win64Format
      SoftwareName  = 'Mozilla Firefox'
      ReleaseNotes  = "https://www.mozilla.org/en-US/firefox/${version}/releasenotes/"
      PackageName   = 'Firefox'
      ExeName       = "Firefox Setup ${version}.exe"
    })

  $data = GetVersionAndUrlFormats -UpdateUrl $releasesESR -Product "$product"
  $version = $data.Version

  $streams.Add('esr', @{
      LocaleURL     = "$releasesESR"
      Version       = $version
      RemoteVersion = $version
      Win32Format   = $data.Win32Format
      Win64Format   = $data.Win64Format
      SoftwareName  = 'Mozilla Firefox*ESR'
      ReleaseNotes  = "https://www.mozilla.org/en-US/firefox/${version}/releaseNotes/"
      ExeName       = "Firefox Setup ${version}esr.exe"
      PackageName   = 'FirefoxESR'
    })

  return @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
