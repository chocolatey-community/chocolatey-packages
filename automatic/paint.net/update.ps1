Import-Module AU

function global:au_SearchReplace {
  @{
      ".\legal\VERIFICATION.txt" = @{
        "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
        "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
      }
  }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $releaseUrl = 'https://www.getpaint.net/index.html'
    $versionRegEx = 'paint\.net\s+([0-9\.]+)'
    $urlString = 'https://www.dotpdn.com/files/paint.net.$version.install.zip'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)
    $url = $ExecutionContext.InvokeCommand.ExpandString($urlString)

    return @{ Url32 = $url; Version = $version }
}

update -ChecksumFor none
