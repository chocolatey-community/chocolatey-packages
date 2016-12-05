$packageName = '{{PackageName}}'

try {
  Remove-Item "$Home\Desktop\MessengerReviver.exe.lnk"
  # the following is all part of error handling
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}
