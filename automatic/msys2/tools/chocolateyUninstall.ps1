$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$pp = Import-Clixml $toolsDir\pp.xml
if (!$pp.NoPath)  { 
    $user_path = [System.Environment]::GetEnvironmentVariable('PATH',  'User')
    $newPath = $user_path.Replace(";" + $pp.InstallDir, '')
    if ($newPath -ne $user_path) { 
        Write-Host "Removing from user PATH"
        [System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'User')
    }
} 

Write-Host "Please remove install dir manually when you don't need it anymore."
Write-Host "Install dir: " $pp.InstallDir