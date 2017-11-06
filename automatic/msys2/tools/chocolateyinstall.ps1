$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$is64     = (Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true'
$dir_name = if ($is64) { 'msys64' } else { 'msys32' }

$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir =  "{0}\{1}" -f (Get-ToolsLocation), $dir_name  }
$install_dir = $pp.InstallDir
$pp | Export-Clixml $toolsDir\pp.xml

if (!(Test-Path $install_dir)) {
    Write-Host "Installing to:" $install_dir
    $packageArgs = @{
        PackageName    = $Env:ChocolateyPackageName
        FileFullPath   = gi $toolsDir\*-i686*
        FileFullPath64 = gi $toolsDir\*-x86_64*
        Destination    = $install_dir
    }
    Get-ChocolateyUnzip @packageArgs
    rm $toolsPath\*.xz -ea 0

    $tarFile = gi "$install_dir\*.tar"
    Get-ChocolateyUnzip $tarFile $install_dir
    rm "$install_dir\*.tar" -ea 0
    $tardir = gi "$install_dir\msys*"
    if ([String]::IsNullOrWhiteSpace($tardir)) { throw "Can't find msys* directory from tar archive" }
    mv $tardir\* $install_dir; rm $tardir
} else { Write-Host "'$install_dir' already exists and will only be updated." }

if ($proxy = Get-EffectiveProxy) {
  Write-Host "Using CLI proxy:" $proxy
  $Env:http_proxy = $Env:https_proxy = $proxy
}

#https://github.com/msys2/msys2/wiki/MSYS2-installation
Write-Host "Starting initialization via msys2_shell.cmd"
Start-Process "$install_dir\msys2_shell.cmd" -Wait -ArgumentList '-c', exit

if (!$pp.NoPath) {  Install-ChocolateyPath $pp.InstallDir }

if (!$pp.NoUpdate) {
    Write-Host "Repeating system update until there are no more updates or max 5 iterations"
    $ErrorActionPreference = 'Continue'     #otherwise bash warnings will exit
    sal bash "$install_dir\usr\bin\bash.exe"
    while (!$done) {
        Write-Host "`n================= SYSTEM UPDATE $((++$i)) =================`n"
        bash -lc 'pacman --noconfirm -Syuu | tee /update.log'
        $done = (gc $install_dir\update.log) -match 'there is nothing to do' | Measure | % { $_.Count -eq 2 }
        $done = $done -or ($i -ge 5)
    }
    rm $install_dir\update.log -ea 0
}
