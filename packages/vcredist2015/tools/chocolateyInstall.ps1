$packageName = 'vcredist2015'
$installerType = 'exe'
$url = 'http://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x86.exe'
$checksum = 'bfb74e498c44d3a103ca3aa2831763fb417134d1'
$checksumType = 'sha1'
$url64 = 'http://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe'
$checksum64 = '3155cb0f146b927fcc30647c1a904cd162548c8c'
$checksumType64 = 'sha1'
$silentArgs = '/Q /norestart'
$validExitCodes = @(0,3010)  # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

$osVersion = (Get-WmiObject Win32_OperatingSystem).Version
Write-Verbose "OS Version: $osVersion"
if(($osVersion -ge [version]"6.3.9600") -AND ($osVersion -lt [version]"6.4")) {
	$hotfix = Get-HotFix | where hotfixID -eq KB2919355
	Write-Verbose "Hotfix KB2919355: $hotfix"
	if($hotfix -eq $null) {
		Write-Warning "$packageName need Update KB2919355 installed first."
		return;
	}
}

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -Url "$url" `
                          -Url64bit "$url64" `
                          -SilentArgs "$silentArgs" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"

if (Get-ProcessorBits 64) {
	Write-Verbose "Install also 32bit version on 64bit operation system."
  Install-ChocolateyPackage -PackageName "$packageName" `
                            -FileType "$installerType" `
                            -Url "$url" `
                            -SilentArgs "$silentArgs" `
                            -ValidExitCodes $validExitCodes `
                            -Checksum "$checksum" `
                            -ChecksumType "$checksumType"
}