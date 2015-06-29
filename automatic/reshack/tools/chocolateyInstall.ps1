$packageName = '{{PackageName}}'
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes

# I need to add an 'open with resource hacker' context menu item for .exe only
# "C:\Program Files (x86)\Resource Hacker\ResHacker.exe"
# if 32 bit
# %ProgramFiles%\Resource Hacker\ResHacker.exe
# if 64 bit
# %ProgramFiles(x86)%\Resource Hacker\ResHacker.exe
