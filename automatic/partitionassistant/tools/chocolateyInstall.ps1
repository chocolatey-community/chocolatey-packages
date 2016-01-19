$name	= 'AOMEI Partition Assistant Standard'
$id		= '{{PackageName}}'
$url	= '{{DownloadUrl}}'
$pwd	= "$(split-path -parent $MyInvocation.MyCommand.Definition)"

Write-Output
Write-Output "The installation is unattended." -ForegroundColor "White"
Write-Output "However, AOMEI PA Lite Server will open after installing." -ForegroundColor "White"
Write-Output "Sorry!" -ForegroundColor "White"
Write-Output

Install-ChocolateyPackage "$id" 'EXE' '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' "$url"
