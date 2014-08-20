$package = 'Brackets'

try {
  $params = @{
    PackageName = $package;
    FileType = 'msi';
    SilentArgs = '/q';
    Url = 'http://download.brackets.io/file.cfm?platform=WIN&build=37';
  }

  Install-ChocolateyPackage @params

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
