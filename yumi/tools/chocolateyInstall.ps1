$packageName = 'yumi'
$fileFullPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\yumi.exe"
$url = '{{DownloadUrl}}'

Get-ChocolateyWebFile $packageName $fileFullPath $url

Install-ChocolateyDesktopLink $fileFullPath