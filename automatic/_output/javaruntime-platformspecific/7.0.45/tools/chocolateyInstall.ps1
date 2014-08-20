$name   = "javaruntime-platformspecific"
$type   = "exe"
$silent = "/s REBOOT=Suppress JAVAUPDATE=0"
$java   = Join-Path $ENV:PROGRAMFILES "Java\jre7"
$bin    = Join-Path $java "bin"

# Find download URLs at http://www.java.com/en/download/manual.jsp
$url    = "http://javadl.sun.com/webapps/download/AutoDL?BundleId=81819"
$url64  = "http://javadl.sun.com/webapps/download/AutoDL?BundleId=81821"

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
