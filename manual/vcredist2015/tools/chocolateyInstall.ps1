$packageName = 'vcredist2015'
$installerType = 'exe'
$url = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x86.exe'
$checksum = '72211bd2e7dfc91ea7c8fac549c49c0543ba791b'
$checksumType = 'sha1'
$url64 = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe'
$checksum64 = '10b1683ea3ff5f36f225769244bf7e7813d54ad0'
$checksumType64 = 'sha1'
$silentArgs = '/Q /norestart'
$validExitCodes = @(0,3010)  # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

$osVersion = (Get-WmiObject Win32_OperatingSystem).Version
Write-Verbose "OS Version: $osVersion"
if(($osVersion -ge [version]"6.3.9600") -AND ($osVersion -lt [version]"6.4")) {
	$hotfix = Get-HotFix | where hotfixID -eq KB2919355
	Write-Verbose "Hotfix KB2919355: $hotfix"
	if($hotfix -eq $null) {
		throw "$packageName need Update KB2919355 installed first. Maybe a restart after installing KB2919355 is needed."
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
  Install-ChocolateyPackage -PackageName "${packageName}_x86" `
                            -FileType "$installerType" `
                            -Url "$url" `
                            -SilentArgs "$silentArgs" `
                            -ValidExitCodes $validExitCodes `
                            -Checksum "$checksum" `
                            -ChecksumType "$checksumType"
}
