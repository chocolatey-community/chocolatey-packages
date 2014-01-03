<#
$package = '{{PackageName}}'

try {

  # http://stackoverflow.com/questions/450027/uninstalling-an-msi-file-from-the-command-line-without-using-msiexec
  $msiArgs = "/X{CA6586CA-1C03-488B-B791-2A4533C1B1C6} /qb-! REBOOT=ReallySuppress"
  Start-ChocolateyProcessAsAdmin "$msiArgs" 'msiexec'

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}

#>