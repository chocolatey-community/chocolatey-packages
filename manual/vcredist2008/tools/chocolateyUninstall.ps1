$packageName = 'vcredist2005'
$packageSearch = "Microsoft Visual C++ 2008 Redistributable*"
$installerType = 'msi'
$silentArgs = '/quiet /qn /norestart'
$validExitCodes = @(0,3010)  # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

Get-ItemProperty -Path @( 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
                          'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
                          'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' ) `
                 -ErrorAction:SilentlyContinue `
| Where-Object   {$_.DisplayName -Like $packageSearch} `
| ForEach-Object {Uninstall-ChocolateyPackage -PackageName "$packageName" `
                                              -FileType "$installerType" `
                                              -SilentArgs "$($_.PSChildName) $silentArgs" `
                                              -ValidExitCodes $validExitCodes}