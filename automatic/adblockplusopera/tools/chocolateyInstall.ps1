$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'

try {
 
if(Test-Path "${Env:ProgramFiles(x86)}\Opera\launcher.exe"){
	start "${Env:ProgramFiles(x86)}\Opera\launcher.exe" "$url"
}
if(Test-Path "${Env:ProgramFiles}\Opera\launcher.exe"){
	start "${Env:ProgramFiles}\Opera\launcher.exe" "$url"
}
if(Test-Path "${Env:ProgramFiles}\Opera\opera.exe"){
	start "${Env:ProgramFiles}\Opera\opera.exe" "$url"
}
if(Test-Path "${Env:ProgramFiles(x86)}\Opera\opera.exe"){
	start "${Env:ProgramFiles(x86)}\Opera\opera.exe" "$url"
}
  
  # the following is all part of error handling
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}