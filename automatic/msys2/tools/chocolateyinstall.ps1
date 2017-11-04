$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$is64     = (Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true'
$dir_name = if ($is64) { 'msys64' } else { 'msys32' }

$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir =  "{0}\{1}" -f (Get-ToolsLocation), $dir_name  }
$install_dir = $pp.InstallDir

if (!(Test-Path $pp.InstallDir)) {
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
    mv $tardir\* $install_dir; rm $tardir
} else { Write-Host "'$($pp.InstallDir)' already exists and will only be updated." }

if (!$pp.NoPath) {  Install-ChocolateyPath $pp.InstallDir }

if (!$pp.NoInit) {
    #https://github.com/msys2/msys2/wiki/MSYS2-installation
    Write-Host "Starting initialization"

    cp $toolsDir\update.sh $install_dir

    Write-Host "Running: msys2_shell.cmd"
    Start-Process "$install_dir\msys2_shell.cmd" -Wait -ArgumentList '-c', exit

    Write-Host "Repeating system update until there are no more updates or max 5 iterations"

    sal bash "$install_dir\usr\bin\bash.exe"
    $ErrorActionPreference = 'Continue'     #otherwise bash warnings will exit
    $i = 0    
    while (!$done) {
        write-host ('='*80) "`n SYSTEM UPDATE" (++$i) ( "`n" + '='*80) 
        bash -lc '. /update.sh'
        $done = ((gc $install_dir\update.log) -match 'there is nothing to do' | Measure | % Count) -eq 2
        $done = $done -or ($i -ge 5)
    }
}