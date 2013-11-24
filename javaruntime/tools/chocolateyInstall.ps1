$name   = '{{PackageName}}'
# Find download URLs at http://www.java.com/en/download/manual.jsp
$url    = '{{DownloadUrl}}'
$url64  = '{{DownloadUrlx64}}'
$type   = 'exe'
$silent = "/s REBOOT=Suppress JAVAUPDATE=0"
$java   = Join-Path $env:ProgramFiles 'Java\jre7'
$bin    = Join-Path $java 'bin'

try {	
  Install-ChocolateyPackage $name $type $silent $url
	
  $is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
  if($is64bit) { 
    Install-ChocolateyPackage $name $type $silent $url64
  }
	
  Install-ChocolateyPath $bin 'Machine'
  Start-ChocolateyProcessAsAdmin @"
[Environment]::SetEnvironmentVariable('JAVA_HOME', '$java', 'Machine')
"@
	
  Write-ChocolateySuccess $name
}
catch {
	Write-ChocolateyFailure $name $($_.Exception.Message)
	return
}
