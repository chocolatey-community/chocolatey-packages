$extractionPath = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]
$installDir = Join-Path $extractionPath 'JetBrains'
$installVersionDir = Join-Path $installDir "WebStorm 2016.3"

if (Test-Path ($installVersionDir)) {
    $uninstallExe = (gci "${installDir}/DataGrip 2016.2.2/bin/Uninstall.exe").FullName | sort -Descending | Select -first 1

    $params = @{
        PackageName = $packageName;
        FileType = "exe";
        SilentArgs = "/S";
        File = $uninstallExe;
    }

    Uninstall-ChocolateyPackage @params
}
