$packageName = '{{PackageName}}'

try {
  Remove-Item "$Home\Desktop\disk2vhd.exe"
  # the following is all part of error handling
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}
