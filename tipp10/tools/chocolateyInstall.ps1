$name = '{{PackageName}}'
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"



try {
	Import-Module "$($pwd)\Get-FilenameFromRegex.ps1"
	# Why does an import failure on this module not throw an error?
	$url = Get-FilenameFromRegex "http://www.tipp10.com/de/download/getfile/0/" '/getfile/0/([\d]+)/' 'http://www.tipp10.com/de/download/getfile/0/$1'
	Write-Host "Found URL: $url"
	Install-ChocolateyPackage "$name" "exe" "/verysilent" "$url"
} catch {
	Write-ChocolateyFailure $name $($_.Exception.Message)
	throw
}