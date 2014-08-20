$packageName = 'tor-browser'

$installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$tempDir = "$env:TEMP\chocolatey\$packageName"

try {

    $language = (Get-Culture).Name -replace '-[a-z]{2}', '' # get language code
    #$language = 'xx' # Language override for testing

    $table = @{
    'en' = 'en-US';
    'ar' = 'ar';
    'de' = 'de';
    'es' = 'es-ES';
    'fa' = 'fa';
    'fr' = 'fr';
    'it' = 'it';
    'nl' = 'nl';
    'pl' = 'pl';
    'pt' = 'pt-PT';
    'ru' = 'ru';
    'vi' = 'vi';
    'zh' = 'zh-CN';
    }

    $langcode = $table[$language]
    # English = fallback language
    if ($langcode -eq $null) {$langcode = 'en-US'}

    # DownloadUrlx64 gets “misused” here as variable for the real version with hyphen
    $url = "https://www.torproject.org/dist/torbrowser/tor-browser-2.3.25-15_${langcode}.exe"

    if (-not (Test-Path $tempDir)) {New-Item $tempDir -ItemType directory}
    $file = "$tempDir\${packageName}.exe"

    Get-ChocolateyWebFile $packageName $file $url
    Start-Process "7za" -ArgumentList "x -o`"$installDir`" -y `"$file`"" -Wait

    $targetFilePath = "$installDir\Tor Browser\Start Tor Browser.exe"
    Install-ChocolateyDesktopLink $targetFilePath

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}