$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
        packageName    = $env:ChocolateyPackageName
        unzipLocation  = $toolsDir
        url            = 'https://github.com/vim/vim-win32-installer/releases/download/v8.1.2056/gvim_8.1.2056_x86.zip'
        url64bit       = 'https://github.com/vim/vim-win32-installer/releases/download/v8.1.2056/gvim_8.1.2056_x64.zip'
        checksum       = 'b04a3b9a6538d216a70a8563ae4de204a1654effbb266850f02ffc72a44b1e50'
        checksum64     = '31927776eac77c3407386f3da377405ba1c8fa34e89ee3d5710e1c79cf8af89c'
        checksumType   = 'sha256'
        checksumType64 = 'sha256'
}
$shortversion = '81'
$params       = Get-PackageParameters
$options      = '-create-batfiles vim gvim evim view gview vimdiff gvimdiff -install-openwith -add-start-menu'
$createvimrc  = '-create-vimrc -vimrc-remap no -vimrc-behave default -vimrc-compat all'
$installpopup = '-install-popup'
$installicons = '-install-icons'
# restart exeplorer.  From vim-tux.install
if ($params['RestartExplorer'] -eq 'true') {
        Write-Debug '/RestartExplorer found.'
        Get-Process explorer | Stop-Process -Force
}
if ($params['NoDefaultVimrc'] -eq 'true') {
        Write-Debug '/NoDefaultVimrc found.'
        $createvimrc = ''
}
if ($params['NoContextmenu'] -eq 'true') {
        Write-Debug '/NoContextmenu found.'
        $installpopup = ''
}
if ($params['NoDesktopShortcuts'] -eq 'true') {
        Write-Debug '/NoDesktopShortcuts found.'
        $installicons = ''
}
$installArgs = @{
        statement = $options, $createvimrc, $installpopup, $installicons -join ' '
        exeToRun  = "$toolsDir\vim\vim$shortversion\install.exe"
}
Write-Debug '$packageArgs'
Write-Debug $packageArgs
Write-Debug '$installArgs'
Write-Debug $installArgs
Install-ChocolateyZipPackage @packageArgs
Start-ChocolateyProcessAsAdmin @installArgs
Copy-Item "$toolsDir\vim\vim$shortversion\vimtutor.bat" $env:windir
$noshimfiles = 'diff', 'gvim', 'install', 'tee', 'uninstal', 'vim', 'vimrun', 'winpty-agent', 'xxd'
foreach ($noshimfile in $noshimfiles) {
        New-Item "$toolsDir\vim\vim$shortversion\$noshimfile.exe.ignore" -type file -force | Out-Null
}
