$ErrorActionPreference = 'Stop';

$packageName = '{{PackageName}}'
$packageSearch = 'Vagrant'
$installerType = 'msi' 
$silentArgs = "/qn /norestart"
# https://msdn.microsoft.com/en-us/library/aa376931(v=vs.85).aspx
$validExitCodes = @(0, 3010, 1605, 1614, 1641)

Get-ItemProperty  -Path @( 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
                          'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
                          'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' ) `
                  -ErrorAction:SilentlyContinue `
  | Where-Object   { $_.DisplayName -like "$packageSearch*" } `
  | ForEach-Object { 
      Uninstall-ChocolateyPackage -PackageName "$packageName" `
                                  -FileType "$installerType" `
                                  -SilentArgs "$($_.PSChildName) $silentArgs" `
                                  -ValidExitCodes $validExitCodes 
    }
