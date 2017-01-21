$ErrorActionPreference = 'Stop';

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$filePath32 = "$toolsPath\tcmd900ax32.exe"
$filePath64 = "$toolsPath\tcmd900ax64.exe"
$filePathInstaller = "$toolsPath\installer.zip"

$packageName = "totalcommander"
$chocoTempDir = Join-Path $Env:Temp "chocolatey"
$tempDir = Join-Path $chocoTempDir "$packageName"

$installFile = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
    Write-Host "Installing 64 bit version"
    $filePath64
} else { 
    Write-Host "Installing 32 bit version"
    $filePath32
}

# Parse package parameters.
$pp = Get-PackageParameters
$localUser = 'UserName=' + if ($pp.LocalUser) { '' } else { '*' }
$desktopIcon = 'mkdesktop=' + if ($pp.DesktopIcon) { '1' } else { '0' }
$installPath = 'Dir=' + if ($pp.InstallPath) { $pp.InstallPath } else { '%ProgramFiles%\totalcmd' }

# Extract EXE to change install options.
Write-Verbose "Extract EXE to change install options."
$tcmdWork = Join-Path $tempDir "tcmd"
$proc = Start-Process -FilePath "7za"
                      -ArgumentList "x -y -o`"$tcmdWork`" `"$installFile`""
                      -Wait
                      -NoNewWindow
                      -PassThru
$proc.WaitForExit()
$exitCode = $proc.ExitCode
if($exitCode -ne 0) {
    throw "Exit Code: $exitCode. Error executing 7za to unzip $installFile into $tcmdWork"
}

# Extract installer.
Write-Verbose "Extract installer."
$installExeSourceBasePath = Join-Path $tempDir "tcmdinstaller"
$proc = Start-Process -FilePath "7za"
                      -ArgumentList "x -y -o`"$installExeSourceBasePath`" `"$filePathInstaller`""
                      -Wait
                      -NoNewWindow
                      -PassThru
$proc.WaitForExit()
$exitCode = $proc.ExitCode
if($exitCode -ne 0) {
    throw "Exit Code: $exitCode. Error executing 7za to unzip $filePathInstaller into $installExeSourceBasePath"
}

# Add launcher to extracted EXE.
Write-Verbose "Add launcher to extracted EXE"
$installExeName = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
    "INSTALL.EXE"
} else { 
    "INSTALL.EXE"
}

$installExeSourcePath = Join-Path $installExeSourceBasePath $installExeName
$installExeTargetPath = Join-Path $tcmdWork $installExeName
Copy-Item -Path $installExeSourcePath -Destination $installExeTargetPath -Force

# Modify install options to make silent.
Write-Verbose "Modify install options to make silent"
$installInf = Join-Path $tcmdWork "INSTALL.INF"
(Get-Content $installInf) -Replace 'UserName=',"$localUser" `
                          -Replace 'auto=0','auto=1' `
                          -Replace 'hidden=0','hidden=1' `
                          -Replace 'mkdesktop=1',"$desktopIcon" `
                          -Replace 'Dir=c:\\totalcmd',"$installPath" | Set-Content $installInf

# Run installer.
$packageArgs = @{
    PackageName = $packageName
    FileType = 'exe'
    SoftwareName = 'Total Commander*'
    File = $installFile
    SilentArgs = ''
    ValidExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer as there is no more need for it.
Remove-Item -Force $filePath32 -ea 0
Remove-Item -Force $filePath64 -ea 0
Remove-Item -Force $filePathInstaller -ea 0