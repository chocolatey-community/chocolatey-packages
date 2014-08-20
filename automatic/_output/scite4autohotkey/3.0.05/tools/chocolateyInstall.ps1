$packageName = 'scite4autohotkey'
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\${packageName}Install.exe"
$url    = 'http://fincs.ahk4.net/scite4ahk/dl/SciTE4AHK3005_Install.exe'
$fileType = 'exe'
$statements = ''

# Variables for the AutoHotkey-script
$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile = "`"$scriptPath\install.ahk`""
$exeToRun = "$env:ProgramFiles\AutoHotkey\AutoHotkey.exe"

try {
    if (-not (Test-Path $filePath)) {
    New-Item $filePath -type directory
    }
    Get-ChocolateyWebFile $packageName $fileFullPath $url
    Start-Process $exeToRun -Verb runas -ArgumentList $ahkFile

    Start-ChocolateyProcessAsAdmin $statements $fileFullPath

    Write-ChocolateySuccess $packageName
    } catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}