try {
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  if ($is64bit) {
    $unpath = "${Env:ProgramFiles(x86)}\Audacity\unins000.exe"
  } else {
    $unpath = "${Env:ProgramFiles}\Audacity\unins000.exe"
  }
  Uninstall-ChocolateyPackage '{{PackageName}}' 'EXE' '/S' "$unpath" -validExitCodes @(0)

  # the following is all part of error handling
  Write-ChocolateySuccess '{{PackageName}}'
} catch {
  Write-ChocolateyFailure '{{PackageName}}' "$($_.Exception.Message)"
  throw
}
