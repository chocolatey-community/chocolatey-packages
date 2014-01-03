$package = '{{PackageName}}'

try {
  $params = @{
    PackageName = $package;
    FileType = 'msi';
    SilentArgs = '/q';
    Url = '{{DownloadUrl}}';
  }

  Install-ChocolateyPackage @params

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
