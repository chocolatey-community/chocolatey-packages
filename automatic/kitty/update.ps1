import-module au

$latestRelease = 'https://api.github.com/repos/cyd01/KiTTY/releases/latest'

function global:au_SearchReplace {
  @{ }
}

function downloadFile($url, $filename) {
  if ($filename.EndsWith("_nocompress.exe")) {
    $filename = $filename -replace "_nocompress\.exe$", ".exe"
  }

  $filePath = "$PSScriptRoot\tools\$filename"
  Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $filePath | Out-Null
  return Get-FileHash $filePath -Algorithm SHA256 | % Hash
}

function global:au_BeforeUpdate {
  $text = Get-Content -Encoding UTF8 -Path "$PSScriptRoot\VERIFICATION_Source.txt" -Raw
  $sb = New-Object System.Text.StringBuilder($text)

  $Latest.GetEnumerator() | ? { $_.Key.StartsWith("URL") } | % {
    $fileName = $_.Key.Substring(3)
    $checksum = downloadFile $_.Value $fileName
    $value = [string]::Format("| {0,-20} | {1} | {2,-79} |", $fileName, $checksum, $_.Value)
    $sb.AppendLine($value) | Out-Null
  }
  $value = "".PadLeft(171, '-')
  $sb.Append("|$value|") | Out-Null

  $sb.ToString() | Out-file -Encoding utf8 -FilePath "$PSScriptRoot\legal\VERIFICATION.txt"
}

function global:au_GetLatest {

  $assets = ((Invoke-WebRequest -UseBasicParsing -Uri $latestRelease).Content | ConvertFrom-Json).assets

  $fileName = $assets[0].name

  $version = $fileName.Replace("kitty-bin-", "").Replace(".zip", "")

  $result = @{
    Version = $version
  }

  $result["URL" + $fileName] = New-Object uri($assets[0].browser_download_url)

  return $result
}

update -ChecksumFor none
