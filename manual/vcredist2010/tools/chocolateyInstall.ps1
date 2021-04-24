try { 
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  Install-ChocolateyPackage 'vcredist2010' 'exe' '/Q' 'http://download.microsoft.com/download/C/6/D/C6D0FD4E-9E53-4897-9B91-836EBA2AACD3/vcredist_x86.exe'
  if($is64bit) {
  	Install-ChocolateyPackage 'vcredist2010_x64' 'exe' '/Q' 'http://download.microsoft.com/download/A/8/0/A80747C3-41BD-45DF-B505-E9710D2744E0/vcredist_x64.exe'
  }

  # the following is all part of error handling
  Write-ChocolateySuccess 'vcredist2010'
} catch {
  Write-ChocolateyFailure 'vcredist2010' "$($_.Exception.Message)"
  throw 
}
