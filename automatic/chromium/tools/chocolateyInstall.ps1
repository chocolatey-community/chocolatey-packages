$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\${packageName}Install.exe"

if (!(Test-Path $filePath)) {
  New-Item -ItemType directory -Path $filePath -Force
}

Get-ChocolateyWebFile -packageName $packageName -fileFullPath `
  $fileFullPath -url $url -url64bit $url64bit
Start-Process $fileFullPath
