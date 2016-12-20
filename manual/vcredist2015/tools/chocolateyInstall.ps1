$packageName = 'vcredist2015'
$installerType = 'exe'
$url = 'https://download.microsoft.com/download/C/E/5/CE514EAE-78A8-4381-86E8-29108D78DBD4/VC_redist.x86.exe'
$checksum = '17b381d3adb22f00e4ab47cbd91ce0a5b1ccbc70'
$checksumType = 'sha1'
$url64 = 'https://download.microsoft.com/download/C/E/5/CE514EAE-78A8-4381-86E8-29108D78DBD4/VC_redist.x64.exe'
$checksum64 = '9a19a51d1f40cd5cd5ecb6e4e4f978f18da8212a'
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
