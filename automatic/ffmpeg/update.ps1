Import-Module Chocolatey-AU

$releases = 'https://www.gyan.dev/ffmpeg/builds'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*FileFullPath64\s*=\s*`"`[$]toolsPath\\).*`"" = "`${1}$($Latest.FileName64)`""
    }

    ".\legal\VERIFICATION.txt"      = @{
      "(?i)(\s+x64:).*"     = "`${1} $($Latest.URL64)"
      "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
    }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
  $version = Invoke-WebRequest -Uri "$releases/release-version" -UseBasicParsing

  @{
    URL64   = "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.7z";
    Version = $version
  }
}

update -ChecksumFor none
