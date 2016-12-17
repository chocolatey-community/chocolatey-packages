$packageName = 'vagrant'
$url = '{{DownloadUrl}}'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  url           = $url
  silentArgs    = "/qn /norestart"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
