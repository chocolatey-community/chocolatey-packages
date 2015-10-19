$name	= 'AOMEI Partition Assistant Lite Server'
$id		= '{{PackageName}}'
$url	= '{{DownloadUrl}}'
$pwd	= "$(split-path -parent $MyInvocation.MyCommand.Definition)"



Write-Host
Write-Host "The installation is unattended." -ForegroundColor "White"
Write-Host "However, AOMEI PA Lite Server will open after installing." -ForegroundColor "White"
Write-Host "Sorry!" -ForegroundColor "White"
Write-Host

Install-ChocolateyPackage "$id" 'EXE' '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' "$url"


# We can use this for other packages or CNET helper
#$url	= 'http://www.disk-partition.com/download-lite.html'
#$regex	= '(?ms).*href="(http://download.cnet.com/.+?)".*'
#if (!(Get-Command Get-UrlFromCnet -errorAction SilentlyContinue)) {
#	Import-Module "$($pwd)\Get-UrlFromCnet2.ps1"
#}
#$url = Get-UrlFromCnet "$url" "$regex"
#$url = $url[1]
#$downTarget	= "$pwd\PAssist_Lite_Setup.exe"
#Get-ChocolateyWebFile "$id" "$downTarget" $url
