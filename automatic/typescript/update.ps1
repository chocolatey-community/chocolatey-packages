Import-Module AU

$releases = 'https://www.npmjs.com/package/typescript'

function global:au_SearchReplace {
  $releaseNotes = "https://github.com/Microsoft/TypeScript/issues?q=is%3Aissue+milestone%3A%22TypeScript+$($Latest.RemoteVersion)%22+label%3A%22fixed%22+"
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "($($Latest.PackageName)\@)[\d\.]+" = "`${1}$($Latest.RemoteVersion)"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$releaseNotes`${2}"
    }
  }
}
function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  if ($download_page.Content -match '\<strong\>([\d]+\.[\d\.]+)\<\/strong\>') {
    $version32 = $Matches[1]
  }

  @{
    Version = $version32
    RemoteVersion = $version32
  }
}

update -ChecksumFor none
