$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'

$bracketsRegistryVersion = $version -replace '^(\d+\.\d+)\..+', '$1'

$params = @{
  PackageName = $packageName;
  FileType = 'msi';
  SilentArgs = '/q /norestart';
  Url = '{{DownloadUrl}}';
}

# We know that using Win32_Product is bad.
# Is there a better alternative to check if it’s
# already installed?
$alreadyInstalled = Get-WmiObject -Class Win32_Product |
  Where-Object {($_.Name -eq 'Brackets') -and
  ($_.Version -match $bracketsRegistryVersion)}

if ($alreadyInstalled) {
  Write-Output "Brackets $version is already installed. Skipping installation."
} else {
  Install-ChocolateyPackage @params
}
