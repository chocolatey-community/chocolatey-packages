$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$is64     = (Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true'
$dir_name = if ($is64) { 'msys64' } else { 'msys32' }

$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir =  "{0}\{1}" -f (Get-ToolsLocation), $dir_name  }
$install_dir = $pp.InstallDir
$pp | Export-Clixml $toolsDir\pp.xml

if (!(Test-Path $install_dir)) {
    Write-Host "Installing to:" $install_dir
    $packageArgs = @{
        PackageName    = $Env:ChocolateyPackageName
        FileFullPath   = Get-Item $toolsDir\*-i686*
        FileFullPath64 = Get-Item $toolsDir\*-x86_64*
        Destination    = $install_dir
    }
    Get-ChocolateyUnzip @packageArgs
    Remove-Item $toolsDir\*.xz -ea 0

    $tarFile = Get-Item "$install_dir\*.tar"
    Get-ChocolateyUnzip $tarFile $install_dir
    Remove-Item "$install_dir\*.tar" -ea 0
    $tardir = Get-Item "$install_dir\msys*"
    if ([String]::IsNullOrWhiteSpace($tardir)) { throw "Can't find msys* directory from tar archive" }
    Move-Item $tardir\* $install_dir; Remove-Item $tardir
} else { Write-Host "'$install_dir' already exists and will only be updated." }

if ($proxy = Get-EffectiveProxy) {
  Write-Host "Using CLI proxy:" $proxy
  $Env:http_proxy = $Env:https_proxy = $proxy
}

#https://github.com/msys2/msys2/wiki/MSYS2-installation
Write-Host "Starting initialization via msys2_shell.cmd"
Start-Process -FilePath "$install_dir\msys2_shell.cmd" -NoNewWindow -Wait -ArgumentList "-defterm","-no-start","-c","`"ps -ef|grep '\?'|grep -v grep|awk '{print `$2}'|xargs -r kill`""
Get-Process | Where-Object Path -ilike "$install_dir*" | Stop-Process -Force

if (!$pp.NoPath) {  Install-ChocolateyPath $pp.InstallDir }

if (!$pp.NoUpdate) {
    Write-Host "Repeating system update until there are no more updates or max 5 iterations"
    $ErrorActionPreference = 'Continue'     #otherwise bash warnings will exit
    while (!$done) {
        Write-Host "`n================= SYSTEM UPDATE $((++$i)) =================`n"
        Start-Process -FilePath "$install_dir\msys2_shell.cmd" -NoNewWindow -Wait -ArgumentList "-defterm","-no-start","-c","`"pacman --noconfirm -Syuu | tee /update.log; ps -ef|grep '\?'|grep -v grep|awk '{print `$2}'|xargs -r kill`""
        $done = (Get-Content $install_dir\update.log) -match 'there is nothing to do' | Measure-Object | ForEach-Object { $_.Count -eq 2 }
        $done = $done -or ($i -ge 5)
        Get-Process | Where-Object Path -ilike "$install_dir*" | Stop-Process -Force
    }
    Remove-Item $install_dir\update.log -ea 0
}
