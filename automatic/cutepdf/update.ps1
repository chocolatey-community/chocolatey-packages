import-module au

 . "$PSScriptRoot\update_helper.ps1"
  $url = 'http://www.cutepdf.com/download/CuteWriter.exe'
  $PackageFileName = ( $url -split('\/') )[-1]

function global:au_SearchReplace {
	@{
		'tools\ChocolateyInstall.ps1' = @{
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
		}
	 }
}

function global:au_AfterUpdate {
  "$($Latest.ETAG)|$($Latest.Version)" | Out-File "$PSScriptRoot\info" -Encoding utf8
}

function global:au_GetLatest {
  $url32 = Get-RedirectedUrl $url
  $etag = GetETagIfChanged $url32
  if ($etag) {
    $result = GetResultInformation -url32 $url32 -file $PackageFileName
    $result["ETAG"] = $etag
  }
  else {
    $result = @{
      URL32   = $url32
      Version = Get-Content "$PSScriptRoot\info" -Encoding UTF8 | select -First 1 | % { $_ -split '\|' } | select -Last 1
    }
  }
  return $result
}

update -NoCheckUrl -ChecksumFor 32
