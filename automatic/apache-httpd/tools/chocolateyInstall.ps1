$ErrorActionPreference = 'Stop';

$packageName  = $env:chocolateyPackageName
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$installLocation = GetInstallLocation $toolsPath "Apache/httpd-$env:chocolateyPackageVersion"
$serviceName = "Apache"

if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
$optionsFile = (Join-Path $PSScriptRoot 'options.xml')

if ($installLocation) {
  Write-Host "Uninstalling previous version of apache-httpd..."
  UninstallPackage -libDirectory "$toolsPath\.." -packageName $env:chocolateyPackageName
  Uninstall-ChocolateyPath $installLocation
}

if ($installLocation) {
  Write-Host "Uninstalling previous version of apache-httpd..."
  UninstallPackage -libDirectory "$toolsPath\.." -packageName $env:chocolateyPackageName
  Uninstall-ChocolateyPath $installLocation
}

$pp = Get-PackageParameters

$downloadInfo = GetDownloadInfo -downloadInfoFile "$toolsPath\downloadInfo.csv" -parameters $pp

$packageArgs = @{
  packageName   = $packageName
  url            = $downloadInfo.URL32
  url64Bit       = $downloadInfo.URL64
  checksum       = $downloadInfo.Checksum32
  checksum64     = $downloadInfo.Checksum64
  checksumType   = 'sha1'
  checksumType64 = 'sha1'
}

$newInstallLocation = $packageArgs.unzipLocation = GetNewInstallLocation $packageArgs.packageName $env:ChocolateyPackageVersion $pp

Write-Debug "Installing to $installLocation, creating service $serviceName"

Install-ChocolateyInstallPackage @packageArgs

if (!$pp.DontAddToPath) {
  Install-ChocolateyPath $newInstallLocation
}

$htdocs_path = $newInstallLocation + '/htdocs'
$conf_path = $newInstallLocation + '/conf'

if ($installLocation -ne $newInstallLocation) {
    if  (Test-Path "$installLocation\htdocs") {
        Write-Host "Moving old htdocs folder."
        Move-Item "$installLocation\htdocs" "$htdocs_path"
    }
    if (Test-Path "$installLocation\conf") {
      Write-Host "Moving old conf folder."
      Move-Item "$installLocation\conf" "$conf_path"
    }

    $di = Get-ChildItem $installLocation -ea 0 | Measure-Object
    if ($di.Count -eq 0) {
    Write-Host "Removing old install location."
    Remove-Item -Force -ea 0 $installLocation
    }
}

$binPath = (Join-Path $installLocation 'Apache24\bin')

Write-Debug "Installing Service $binPath : $serviceName"

Push-Location $binPath
Start-ChocolateyProcessAsAdmin ".\httpd.exe -k install -n '$($serviceName)'"
Pop-Location

$options = @{
    version = $env:chocolateyPackageVersion;
    unzipLocation = $installLocation;
    serviceName = $serviceName;
}

Export-CliXml -Path $optionsFile -InputObject $options
