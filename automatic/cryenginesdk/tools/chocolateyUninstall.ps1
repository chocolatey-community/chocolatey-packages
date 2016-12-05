$packageName = '{{PackageName}}'

try {
  Remove-Item "$Home\Desktop\DedicatedServerSDK.exe.lnk"
  Remove-Item "$Home\Desktop\Editor.exe.lnk"
  Remove-Item "$Home\Desktop\GameSDK.exe.lnk"
  # the following is all part of error handling
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}
