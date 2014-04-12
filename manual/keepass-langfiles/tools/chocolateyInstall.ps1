try {

    $name = "keepass-langfiles"
    $scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
    $fileFullPath = "$scriptPath\keepass_2.x_langfiles.zip"

    $keepasspath = "$env:ProgramFiles\KeePass Password Safe 2"
    $keepasspathx86 = "${env:ProgramFiles(x86)}\KeePass Password Safe 2"
    if (Test-Path "$keepasspath") {$destination = "$keepasspath"}
    if (Test-Path "$keepasspathx86") {$destination = "$keepasspathx86"}

    $extractPath = "$scriptPath\keepass-langfiles"
    if (-not (Test-Path $extractPath)) {
        mkdir $extractPath
    }

    Get-ChocolateyUnzip $fileFullPath $extractPath
    Start-ChocolateyProcessAsAdmin "Copy-Item -Force '$extractPath\*.lngx' '$destination'"

        Write-ChocolateySuccess $name
} catch {
    Write-ChocolateyFailure $name $($_.Exception.Message)
    throw
}
