$package = 'Brackets'

try {
  $params = @{
    PackageName = $package;
    FileType = 'msi';
    SilentArgs = '/q';
    Url = 'https://github.com/adobe/brackets/releases/download/sprint-38/Brackets.Sprint.38.msi';
  }

  Install-ChocolateyPackage @params

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
