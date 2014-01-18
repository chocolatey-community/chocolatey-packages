$name   = "{{PackageName}}"
$type   = "exe"
$silent = "/s REBOOT=Suppress"
$java   = Join-Path $ENV:PROGRAMFILES "Java\jre7"
$bin    = Join-Path $java "bin"

# Find download URLs at http://www.java.com/en/download/manual.jsp
$url    = "{{DownloadUrl}}"
$url64  = "{{DownloadUrlx64}}"

try {  
  Install-ChocolateyPackage $name $type $silent $url $url64
  Install-ChocolateyPath $bin "Machine"
  Start-ChocolateyProcessAsAdmin @"
[Environment]::SetEnvironmentVariable("JAVA_HOME", "$java", "Machine")
"@
  
  Write-ChocolateySuccess $name
}
catch {
  Write-ChocolateyFailure $name $_.Exception.Message
  return
}
