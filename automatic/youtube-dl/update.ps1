Import-Module Chocolatey-AU
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

function global:au_BeforeUpdate {
  if (Test-Path "$PSScriptRoot\tools") {
    Remove-Item "$PSScriptRoot\tools\*.exe" -Force
  } else {
    New-Item -ItemType Directory "$PSScriptRoot\tools"
  }
  $Latest.FileName = Get-WebFileName $Latest.URL32 'youtube-dl.exe'
  $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"
  Get-WebFile $Latest.URL32 $filePath
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(listed on\s*)\<.*\>" = "`${1}<$($Latest.ReleaseUrl)>"
      "(?i)(1\..+)\<.*\>"          = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType32)"
      "(?i)(checksum:).*"       = "`${1} $($Latest.Checksum32)"
    }
  }
}

function global:au_GetLatest {
  $streams = [ordered]@{}
  foreach ($repository in 'youtube-dl','ytdl-nightly') {
    $latestRelease = Get-GitHubRelease -Owner ytdl-org -Name $repository
    $url = $latestRelease.assets.Where{$_.name -eq 'youtube-dl.exe'}.browser_download_url

    $version = $latestRelease.tag_name.TrimStart('v')
    if ($repository.EndsWith('nightly')) {
      $version += '-nightly'
    }

    # Look for a checksum asset for SHA512
    $checksumFile = $latestRelease.assets.Where{$_.name -eq 'SHA2-512SUMS'}

    # If it exists
    $checksum = if ($checksumFile) {
      # Get the content of the file
      $checksumFileContent = (-join [char[]](Invoke-WebRequest -Uri $ChecksumFile.browser_download_url -UseBasicParsing).content).Split("`n")

      # Find the line for youtube-dl.exe
      $youtubeDlExeChecksumLine = $checksumFileContent -match "^(?<checksum>.+)(?=\s+youtube-dl\.exe)"

      # And output the checksum portion, which is the first part of the line
      $youtubeDlExeChecksumLine.Split(' ')[0]
    } else {
      # Otherwise, use Get-RemoteChecksum to output a SHA512 checksum for the asset URL
      Get-RemoteChecksum -Url $Url -Algorithm "sha512"
    }

    $streams.Add(
      $repository,
      @{
        Version        = $version
        URL32          = $url
        Checksum32     = $checksum
        ChecksumType32 = "sha512"
        ReleaseUrl     = $latestRelease.html_url
      }
    )
  }

  @{
    streams = $streams
  }
}

update -ChecksumFor none
