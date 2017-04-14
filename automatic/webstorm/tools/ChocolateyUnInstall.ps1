$packageName = 'WebStorm 2016.3'
$programsDir = 'JetBrains';
$extractionPath = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]
$installDir = Join-Path $extractionPath $programsDir
$installVersionDir = Join-Path $installDir $packageName

if (Test-Path ($installVersionDir)) {
    $uninstallExe = (gci "${installDir}/$packageName/bin/Uninstall.exe").FullName | sort -Descending | Select -first 1

    $params = @{
        PackageName = $packageName;
        FileType = "exe";
        SilentArgs = "/S";
        File = $uninstallExe;
    }

    Uninstall-ChocolateyPackage @params
}
