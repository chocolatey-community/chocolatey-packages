$packageName = '{{PackageName}}'
$installerType = 'exe'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"



# Combatibility - This function has not been merged
if (!(Get-Command Get-UrlFromFosshub -errorAction SilentlyContinue)) {
	Import-Module "$($pwd)\Get-UrlFromFosshub.ps1"
}

$url = Get-UrlFromFosshub $url
$url64 = Get-UrlFromFosshub $url64

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes
