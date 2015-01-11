  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  if ($is64bit) {
    & "${Env:ProgramFiles(x86)}\Trillian\trillian.exe" /uninstall
  } else {
    & "$Env:ProgramFiles\Trillian\trillian.exe" /uninstall
  }
 