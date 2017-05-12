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

if (!$pp.Site) { $pp.Site = 'http://mirrors.kernel.org/sourceware/cygwin/' }
Write-Host "Download site: $($pp.Site)"

$silentArgs = @(
    '--quiet-mode'
    "--site $($pp.Site)"
    '--packages default'
    "--root $cygwin_root"
    "--local-package-dir $cygwin_root"

    if (!$pp.DesktopIcon) { '--no-desktop' } else {  Write-Host 'Desktop icon will be created' }
    if ($pp.NoStartMenu)  { '--no-startmenu';        Write-Host 'No start menu items will be created' }
    if ($pp.Proxy)        { "--proxy $($pp.Proxy)";  Write-Host "Using proxy: $($pp.Proxy)" }
    if ($pp.Pubkey)       { "--pubkey $($pp.Pubkey)";Write-Host "URL of extra public key file is provided" }
    if ($pp.NoAdmin)      { '--no-admin';            Write-Host "Do not require running as administrator" }
)

$packageArgs = @{
  packageName            = 'Cygwin'
  fileType               = 'exe'
  url                    = 'https://cygwin.com/setup-x86.exe'
  url64bit               = 'https://cygwin.com/setup-x86_64.exe'
  checksum               = '406bfa31d0c724de90aced5edddaf07f3eac46220c9cc9998ae2428d13989c28'
  checksum64             = 'b67afe083b2547acee0857b45ff9784f873d1fb226a0148c1364f255180fc282'
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
