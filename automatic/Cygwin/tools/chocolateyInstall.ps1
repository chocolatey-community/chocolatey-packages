$packageName = '{{PackageName}}'
$installerType = 'exe'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$validExitCodes = @(0)

$binRoot = Get-BinRoot
$cygRoot = join-path $binRoot 'cygwin'
$cygWinSetupFile = "$cygRoot\cygwinsetup.exe"
$cygPackages = join-path $cygRoot packages

if (!(Test-Path($cygRoot))) {
  [System.IO.Directory]::CreateDirectory($cygRoot) | Out-Null  
}

Get-ChocolateyWebFile $packageName $cygWinSetupFile $url $url64 

# https://cygwin.com/faq/faq.html#faq.setup.cli
$silentArgs = "--quiet-mode --root $cygRoot --local-package-dir $cygPackages -s http://mirrors.kernel.org/sourceware/cygwin/ --download --packages default"

Install-ChocolateyInstallPackage $packageName $installerType $silentArgs $cygWinSetupFile -validExitCodes $validExitCodes

Install-ChocolateyPath $cygRoot
