﻿Import-Module Chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://www.pendrivelinux.com/universal-usb-installer-easy-as-1-2-3/'
$padUnderVersion = '1.9.8'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameBase $Latest.PackageName }

function global:au_SearchReplace {
  @{
    '.\legal\VERIFICATION.txt' = @{
      '(?i)(^\s*location on\:?\s*)\<.*\>' = "`${1}<$releases>"
      '(?i)(\s*1\..+)\<.*\>'              = "`${1}<$($Latest.URL32)>"
      '(?i)(^\s*checksum\s*type\:).*'     = "`${1} $($Latest.ChecksumType32)"
      '(?i)(^\s*checksum(32)?\:).*'       = "`${1} $($Latest.Checksum32)"
    }
  }
}

function Convert-CharacterToNumber {
  param(
    [Parameter(Mandatory)]
    [char] $character
  )

  $newNum = ([int]$character) + 1

  $newNum - [int]([char]'a')
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re = '\.exe$'
  $url32 = $download_page.Links | Where-Object href -Match $re | Select-Object -First 1 -expand href
  if ($url32.StartsWith('/')) {
    $url32 = [uri]::new([uri]$releases, $url32)
  }

  $verRe = '[-]|\.exe$'
  $version32 = $url32 -split "$verRe" | Select-Object -Last 1 -Skip 1

  if ($version32 -match "^([\d\.]+)([a-z])$") {
    $m1 = $Matches[1]
    $num = Convert-CharacterToNumber $Matches[2]
    $version32 = "${m1}$num"
  }

  @{
    URL32   = $url32
    Version = Get-FixVersion $version32 -OnlyFixBelowVersion $padVersionUnder
  }
}

update -ChecksumFor none
