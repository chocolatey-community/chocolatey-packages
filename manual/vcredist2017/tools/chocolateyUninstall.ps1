$packageName = 'vcredist2017'
$packageSearch = 'Microsoft Visual C++ vNext Redistributable' # sic! Microsoft has not changed the name yet.
$installerType = 'exe'
$silentArgs = '/uninstall /quiet'
$validExitCodes = @(0,3010)  # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

Get-ItemProperty -Path @( 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
                        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
                        'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' ) `
               -ErrorAction:SilentlyContinue `
| Where-Object   { $_.DisplayName -Like "$packageSearch*" } `
| ForEach-Object { 
if ( $_.UninstallString -Match '"?(.*?)(".*)?$' ) {
  $unString = $matches[1]
} else {
  Write-Error "No valid UninstallString found."
  Write-Host "Continuing with default UninstallString."
}
Uninstall-ChocolateyPackage -PackageName "$packageName" `
                            -FileType "$installerType" `
                            -SilentArgs "$silentArgs" `
                            -File "$unString" `
                            -ValidExitCodes $validExitCodes
}
