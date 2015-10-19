$name	= 'AOMEI Partition Assistant Standard'
$id		= '{{PackageName}}'
$url	= '{{DownloadUrl}}'
$pwd	= "$(split-path -parent $MyInvocation.MyCommand.Definition)"



Write-Host
Write-Host "The installation is unattended." -ForegroundColor "White"
Write-Host "However, AOMEI PA Lite Server will open after installing." -ForegroundColor "White"
Write-Host "Sorry!" -ForegroundColor "White"
Write-Host

Install-ChocolateyPackage "$id" 'EXE' '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' "$url"
