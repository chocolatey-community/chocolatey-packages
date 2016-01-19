$packageName = '{{PackageName}}'
$fileType = "exe"

$binRoot = "$env:systemdrive\tools"
if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}

$silentArgs = "/VERYSILENT /DIR=$binRoot\nLite"
$url = '{{DownloadUrl}}'
$referer = "http://www.nliteos.com/download.html"
$file = "$env:TEMP\nLite-{{PackageVersion}}.setup.exe"

wget -P "$env:TEMP" --referer=$referer $url

Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file
Remove-Item $file
