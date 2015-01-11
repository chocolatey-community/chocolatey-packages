$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'

try {
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  if ($is64bit) {
    start "${Env:ProgramFiles(x86)}\Mozilla Firefox\firefox.exe" "$url"
  } else {
    start "${Env:ProgramFiles}\Mozilla Firefox\firefox.exe" "$url"
  }
    
  # the following is all part of error handling
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}