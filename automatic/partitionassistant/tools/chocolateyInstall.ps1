$name	= 'AOMEI Partition Assistant Standard'
$id		= 'PartitionAssistant'
$url	= 'http://www.disk-partition.com/download-home.html'
$regex	= '(?ms).*href="(http://download.cnet.com/.+?)".*'
$pwd	= "$(split-path -parent $MyInvocation.MyCommand.Definition)"

# Combatibility - This function has not been merged
if (!(Get-Command Get-UrlFromCnet -errorAction SilentlyContinue)) {
	Import-Module "$($pwd)\Get-UrlFromCnet2.ps1"
}



# Let's get the link from CNET first.
$url = Get-UrlFromCnet "$url" "$regex"
# Warning: Somehow $url is an array now.
$url = $url[1]

# Download manually
$downTarget	= "$pwd\PartitionAssistantSetup.exe"
Write-Host "Trying to download to $downTarget..."
Get-ChocolateyWebFile "$id" "$downTarget" $url

Write-Host
Write-Host "The installation is unattended." -ForegroundColor "White"
Write-Host "However, Partition Assistant will open after installing." -ForegroundColor "White"
Write-Host "Sorry!" -ForegroundColor "White"
Write-Host

# Installer
Write-Host "Trying to install..."
Install-ChocolateyPackage "$id" 'EXE' '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' "$downTarget"
