$name	= 'Unchecky'
$url	= '{{DownloadUrl}}'

# unchecky_setup.exe -install -path <installation_path> [-lang <unchecky_language>] - get command line arguments

try {
	Install-ChocolateyPackage $name 'EXE' '-install' $url
	Write-ChocolateySuccess $name
} catch {
	Write-ChocolateyFailure $name $($_.Exception.Message)
	throw
}
