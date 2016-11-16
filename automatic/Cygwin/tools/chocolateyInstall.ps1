# https://cygwin.com/faq/faq.html#faq.setup.cli

$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters

$cygwin_root = (Get-ItemProperty 'HKLM:\SOFTWARE\Cygwin\setup' -ea 0).rootdir
if (!$cygwin_root) {
    $cygwin_root = if ($pp.InstallDir) { $pp.InstallDir } else { (Get-BinRoot) + '\cygwin' }
} else { Write-Host 'Existing installation detected, ignoring InstallDir argument' }

if (!$pp.Proxy) {
    $pp.Proxy = $Env:ChocolateyProxyLocation
    if (!$pp.Proxy) {
        $wc = New-Object System.Net.WebClient; $url = 'https://cygwin.com'
        $pp.Proxy = if (!$wc.Proxy.IsBypassed($url)) { $wc.Proxy.GetProxy($url).Authority }
    }
}

$silentArgs = @(
    '--quiet-mode'
    '--site http://mirrors.kernel.org/sourceware/cygwin/'
    '--packages default'
    "--root $cygwin_root"
    "--local-package-dir $cygwin_root"

    if (!$pp.DesktopIcon) { '--no-desktop' } else {  Write-Host 'Desktop icon will be created' }
    if ($pp.NoStartMenu)  { '--no-startmenu';        Write-Host 'No start menu items will be created' }
    if ($pp.Proxy)        { "--proxy $($pp.Proxy)";  Write-Host "Using proxy: $($pp.Proxy)" }
    if ($pp.Pubkey)       { "--pubkey $($pp.Pubkey)";Write-Host "URL of extra public key file is provided" }
    if ($pp.Site)         { "--site $($pp.Site)";    Write-Host "Download site: $($pp.Site)" }
)

$packageArgs = @{
  packageName            = 'Cygwin'
  fileType               = 'exe'
  url                    = 'https://cygwin.com/setup-x86.exe'
  url64bit               = 'https://cygwin.com/setup-x86_64.exe'
  checksum               = '5540542d7fa1d1f13453e7a250c1c6de44a6a794e81ffde0dfea6b5689dbc052'
  checksum64             = '446b658bc1b8b6c7865474188cb4d7e9873003e2b6a9d74dcdfb7a3ff77e8634'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = $silentArgs
  validExitCodes         = @(0)
}
Install-ChocolateyPackage @packageArgs
Install-BinFile -Name "Cygwin" -Path "$cygwin_root\Cygwin.bat"

Write-Host "Copying cygwin package manager (setup) to $cygwin_root"
$setup_path = if (Get-ProcessorBits 64) { $packageArgs.url64bit } else { $packageArgs.url }
$setup_path = "{0}\{1}" -f (Get-PackageCacheLocation), ($setup_path -split '/' | select -Last 1)
if (!$setup_path)  { Write-Warning "Can't find setup path"; return }
cp $setup_path $cygwin_root\cygwinsetup.exe
