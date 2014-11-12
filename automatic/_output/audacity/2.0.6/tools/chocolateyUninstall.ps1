try {
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  if ($is64bit) {
    $unpath = "${Env:ProgramFiles(x86)}\Audacity\unins000.exe"
  } else {
    $unpath = "${Env:ProgramFiles}\Audacity\unins000.exe"
  }
  Uninstall-ChocolateyPackage 'audacity' 'EXE' '/S' "$unpath" -validExitCodes @(0)

  # the following is all part of error handling
  Write-ChocolateySuccess 'audacity'
} catch {
  Write-ChocolateyFailure 'audacity' "$($_.Exception.Message)"
  throw
}
