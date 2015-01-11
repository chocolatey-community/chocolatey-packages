$packageName = '{{PackageName}}'

try {
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  if ($is64bit) {
	& "C:\Program Files (x86)\AVG\AVG2014\avgmfapx.exe" /Appmode=Setup /uninstall /uilevel=Silent /dontrestart
  } else {
    & "C:\Program Files\AVG\AVG2014\avgmfapx.exe" /Appmode=Setup /uninstall /uilevel=Silent /dontrestart
  }
   
  # the following is all part of error handling
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}