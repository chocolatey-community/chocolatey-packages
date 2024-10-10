﻿Import-Module Chocolatey-AU
. "$PSScriptRoot\..\Firefox\update_helper.ps1"

$releases = 'https://www.mozilla.org/en-US/thunderbird/all/'
$product  = 'thunderbird'

function global:au_AfterUpdate {
  $version = $Latest.RemoteVersion
  CreateChecksumsFile -ToolsDirectory "$PSScriptRoot\tools" `
    -ExecutableName "Thunderbird Setup $version.exe" `
    -Version $version `
    -Product $product
}

function global:au_SearchReplace {
  $version = $Latest.RemoteVersion

  SearchAndReplace -PackageDirectory "$PSScriptRoot" `
    -Data $Latest
}

function global:au_GetLatest {
  $data  = GetVersionAndUrlFormats -UpdateUrl $releases -Product $product

  @{
    LocaleURL = "$releases"
    Version = $data.Version
    RemoteVersion = $data.Version
    Win32Format = $data.Win32Format
    Win64Format = $data.Win64Format
    SoftwareName = 'Mozilla Thunderbird'
  }
}

update -ChecksumFor none
