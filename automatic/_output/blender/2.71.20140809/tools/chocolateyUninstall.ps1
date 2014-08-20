$packageName = 'blender'
$unfile = "${Env:ProgramFiles}\Blender Foundation\Blender\uninstall.exe"

try {

    if (Test-Path $unfile) {
        Uninstall-ChocolateyPackage $packageName 'exe' '/S' $unfile
    }

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
