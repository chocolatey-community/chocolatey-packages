$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'

try {

if(Test-Path "${Env:LOCALAPPDATA}\Google\Chrome\Application\chrome.exe"){
	& "${Env:LOCALAPPDATA}\Google\Chrome\Application\chrome.exe" "$url"
}
if(Test-Path "${Env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"){
	& "${Env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe" "$url"
}

  # the following is all part of error handling
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}


#C:\Users\Tonin\AppData\Local\Google\Chrome\User Data\Default\Extensions\cfhdojbkjhnklbpkdaibdccddilifddb

  