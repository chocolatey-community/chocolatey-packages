Import-Module Chocolatey-AU

$softwareName = 'Waterfox*'

function global:au_BeforeUpdate {
  if ($Latest.Title -like '*Classic*') {
    Copy-Item "$PSScriptRoot\readme.classic.md" "$PSScriptRoot\readme.md" -Force
  }
  else {
    Copy-Item "$PSScriptRoot\readme.current.md" "$PSScriptRoot\readme.md" -Force
  }

  $Latest.ChecksumType64 = 'sha256'
  $fileName = $Latest.URL64 -split '/' | Select-Object -last 1
  $fileName = ($fileName -replace '%20', ' ').TrimEnd('.exe')
  Get-RemoteFiles -Purge -FileNameBase $fileName
  $Latest.FileName64 = $fileName + "_x64.exe"
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
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
  }
}

function global:au_AfterUpdate {
  Update-Metadata -data @{
    title            = $Latest.Title
    projectUrl       = $Latest.ProjectUrl
    projectSourceUrl = $Latest.SourceUrl
  }
}

function Get-Waterfox {
  param(
    [string]$Build
  )
  switch ($Build) {
    "Classic" {
      $LatestRelease = Get-GitHubRelease WaterfoxCo Waterfox-Classic

      @{
        PackageName = "waterfox-classic"
        Title = "Waterfox classic"
        Url64 = $LatestRelease.assets | Where-Object {$_.name.EndsWith(".exe")} | Select-Object -ExpandProperty browser_download_url
        Version = $LatestRelease.tag_name.TrimEnd("-classic")
        SourceUrl = "https://github.com/WaterfoxCo/Waterfox-Classic"
        ProjectUrl = "https://classic.waterfox.net/"
      }
    }

    "Current" {
      $LatestRelease = Get-GitHubRelease WaterfoxCo Waterfox
      $TagVersion = $LatestRelease.tag_name

      @{
        PackageName = "Waterfox"
        Title = "Waterfox"
        Url64 = if ($SetupAsset = $LatestRelease.assets | Where-Object {$_.name.EndsWith("Setup.exe")}) {
          # As recently as G4.1.5 they have included Setup in the released assets
          $SetupAsset.browser_download_url
        } elseif ($LatestRelease.body -match "\[Download for Windows\]\((?<URL>.+)\)") {
          # As recently as G5.0 Beta 5 they have included download links in the body
          $Matches.URL
        } else {
          # They have many releases that contain no download links and no assets - let's give calculation a go!
          try {
            $TestCdn = @{
              Uri = "https://cdn1.waterfox.net/waterfox/releases/$($TagVersion)/WINNT_x86_64/Waterfox%20Setup%20$($TagVersion).exe"
              UseBasicParsing = $true
              Method = "Head"
              ErrorAction = "Stop"
            }
            if (Invoke-WebRequest @TestCdn) {
              $TestCdn.Uri
            }
          } catch {
            # We're giving up.
            throw "Couldn't find or divine the URL for Waterfox $TagVersion from the GitHub release ('$($LatestRelease.html_url)')"
          }
        }
        Version = $TagVersion.Replace('G', (Get-Date).ToString('yyMM'))
        SourceUrl = "https://github.com/WaterfoxCo/Waterfox"
        ProjectUrl = "https://www.waterfox.net/"
      }
    }
  }
}

function global:au_GetLatest {
  $streams = [ordered] @{
    classic = Get-Waterfox -Build "Classic"
    current = Get-Waterfox -Build "Current"
  }

  return @{ Streams = $streams }
}

update -ChecksumFor none
