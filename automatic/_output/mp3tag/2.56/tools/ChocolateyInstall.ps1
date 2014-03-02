try {
    $packageName = 'mp3tag'
    $fileType = 'exe'
    $silentArgs = '/S'
    $url = 'http://download.mp3tag.de/mp3tagv256setup.exe'

    $iniFile = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\..\content\Mp3tagSetup.ini"
    $chocoTempDir = "$env:TEMP\chocolatey\$packageName\"

    # Automatic language selection
    $iniContent = Get-Content $iniFile
    $LCID = (Get-Culture).LCID
    $iniContent = $iniContent -replace 'language=.+', "language=$LCID"
    $iniContent > $iniFile

    if (-not (Test-Path $chocoTempDir)) {New-Item $chocoTempDir -ItemType directory}
    Copy-Item $iniFile $chocoTempDir -Force

    Install-ChocolateyPackage $packageName $fileType $silentArgs $url

    Write-ChocolateySuccess $packageName
    } catch {
        Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
        throw
}