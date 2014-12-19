$packageName = '{{PackageName}}'
$installerType = 'exe'
$installArgs = '/S'

try {

  $binRoot = Get-BinRoot
  $destinationFolder = Join-Path $binRoot 'tor-browser'

  $pathDownloadedInstaller = Join-Path $env:TEMP 'tor-browserInstall.exe'

  $desktopPath = $([Environment]::GetFolderPath('Desktop'))
  $oldDestinationFolder = Join-Path $desktopPath 'Tor Browser'

  if ((Test-Path $oldDestinationFolder) -and ($oldDestinationFolder -ne $destinationFolder)) {
    $destinationFolder = $oldDestinationFolder

    Write-Output @"
Warning: Deprecated installation folder detected: Desktop/Tor Browser.
This package will continue to install {{PackageName}} there unless you remove the deprecated installation folder.
After you did that, reinstall this package again with the “-force” parameter. Then it will use %ChocolateyBinRoot%\tor-browser.
"@
  }


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
  'ko' = 'ko';
  'nl' = 'nl';
  'pl' = 'pl';
  'pt' = 'pt-PT';
  'ru' = 'ru';
  'tr' = 'tr';
  'vi' = 'vi';
  'zh' = 'zh-CN';
  }

  $langcode = $table[$language]
  # English = fallback language
  if ($langcode -eq $null) {$langcode = 'en-US'}

  # DownloadUrlx64 gets “misused” here as variable for the real version with  hyphen
  $url = "https://www.torproject.org/dist/torbrowser/{{DownloadUrlx64}}/torbrowser-install-{{DownloadUrlx64}}_${langcode}.exe"

  Get-ChocolateyWebFile $packageName $pathDownloadedInstaller $url

  Start-Process -Wait $pathDownloadedInstaller -ArgumentList '/S', "/D=$destinationFolder"

  Remove-Item $pathDownloadedInstaller

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
