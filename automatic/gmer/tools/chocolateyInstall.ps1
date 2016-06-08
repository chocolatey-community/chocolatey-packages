$name	= 'GMER'
$url	= '{{DownloadUrl}}'
$pwd	= "$(split-path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage "$name" "$url" "$pwd"
