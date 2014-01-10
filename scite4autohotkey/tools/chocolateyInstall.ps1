$packageName = '{{PackageName}}'
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\${packageName}Install.exe"
$url    = '{{DownloadUrl}}'
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