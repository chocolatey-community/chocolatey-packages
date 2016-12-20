$name	= 'RenameMaster'
$pwd	= "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$url	= "{{DownloadUrl}}"

# Combatibility - This function has not been merged
if (!(Get-Command Install-ChocolateyPinnedItem -errorAction SilentlyContinue)) {
	Import-Module "$($pwd)\Install-ChocolateyPinnedItem.ps1"
}

 
## $url = Get-FilenameFromRegex "http://www.joejoesoft.com/vcms/hot/userupload/8/files/rmv303.zip" '/cms/file.php\?f=userupload/8/files/rmv303.zip&amp;c=([\w\d]+)' 'http://www.joejoesoft.com/sim/$1/userupload/8/files/rmv303.zip'
# $url = "http://www.joejoesoft.com/cms/file.php?f=userupload%2f8%2ffiles%2frmv311.zip"

#	# Resolve url
#	$wc = new-object system.Net.WebClient;
#	$html = $wc.DownloadString($url);
#	$html -cmatch '/cms/file.php(.+?)"';
#	$url = $matches[0];
#	$url = "http://www.joejoesoft.com" + $url;
#	# remove last double quote.
#	$url = $url.Replace('"','');
	
#	# Calculate $binRoot, which should always be set in $env:ChocolateyBinRoot as a full path (not relative)
#	$binRoot	= Get-BinRoot;
# Override. I thought Get-BinRoot was supposed to do this but guess not: https://groups.google.com/forum/?utm_medium=email&utm_source=footer#!msg/chocolatey/5R7OtVM9RUI/ERcFFKZcFnQJ
$binRoot	= Join-Path $env:ChocolateyInstall "bin"

# Extract from zip, ignore setup.exe
Install-ChocolateyZipPackage $name "$url" "$binRoot"
	
# Copy 'Rename Master' shortcut to start menu
Install-ChocolateyPinnedItem "$binRoot\RenameMaster.exe"

# Add 'Rename Master... to context menu for directories'
Install-ChocolateyExplorerMenuItem 'openRenameMaster' 'Rename Master...' "$binRoot\RenameMaster.exe" directory
