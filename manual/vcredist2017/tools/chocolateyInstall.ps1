$packageName = 'vcredist2017'
$installerType = 'exe'
$url = 'https://download.microsoft.com/download/e/6/6/e66c5871-7afe-4640-a454-786eabe8aae8/vc_redist.x86.exe'
$checksum = 'fdccb907365a76e94b9ddc36538a35709688528f03283047f660aa2cb9bcbb1a'
$checksumType = 'sha256'
$url64 = 'https://download.microsoft.com/download/7/2/5/72572684-052f-4aa9-9170-9d40813a87be/vc_redist.x64.exe'
$checksum64 = 'dbd2a04c202214181e2d7e0618f4b3b88ddfe690c97338a45ca3038daa4adba2'
$checksumType64 = 'sha256'
$silentArgs = '/Q /norestart'
$validExitCodes = @(0,3010)

$osVersion = (Get-WmiObject Win32_OperatingSystem).Version
if(($osVersion -ge [version]"6.3.9600") -AND ($osVersion -lt [version]"6.4")) {
  $hotfix = Get-HotFix | where hotfixID -eq KB2919355
  if($hotfix -eq $null) {
    throw "$packageName needs Update KB2919355 installed first."
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
    Write-Verbose "Installing also 32bit version on 64bit operating system."
    Install-ChocolateyPackage -PackageName "$packageName" `
                            -FileType "$installerType" `
                            -Url "$url" `
                            -SilentArgs "$silentArgs" `
                            -ValidExitCodes $validExitCodes `
                            -Checksum "$checksum" `
                            -ChecksumType "$checksumType"
}
