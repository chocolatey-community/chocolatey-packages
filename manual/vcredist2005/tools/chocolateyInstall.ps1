try { 
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  Install-ChocolateyPackage 'vcredist2005' 'exe' '/Q' 'http://download.microsoft.com/download/e/1/c/e1c773de-73ba-494a-a5ba-f24906ecf088/vcredist_x86.exe'
  if($is64bit) {
  	Install-ChocolateyPackage 'vcredist2005_x64' 'exe' '/Q' 'http://download.microsoft.com/download/d/4/1/d41aca8a-faa5-49a7-a5f2-ea0aa4587da0/vcredist_x64.exe'
  }

  # the following is all part of error handling
  Write-ChocolateySuccess 'vcredist2005'
} catch {
  Write-ChocolateyFailure 'vcredist2005' "$($_.Exception.Message)"
  throw 
}
