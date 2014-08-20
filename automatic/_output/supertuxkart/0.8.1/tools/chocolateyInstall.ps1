try {
    $packageName = 'supertuxkart'
    $url = 'http://sourceforge.net/projects/supertuxkart/files/SuperTuxKart/0.8.1/supertuxkart-0.8.1-win.exe/download'
    $silentArgs = '/S'

    $tempDir = "$env:TEMP\chocolatey\$packageName"
    if (!(Test-Path $tempDir)) {New-Item $tempDir -ItemType directory -Force}
    $fileFullPath = "$tempDir\${packageName}Install.exe"

    Get-ChocolateyWebFile $packageName $fileFullPath $url

    Start-Process $fileFullPath -Verb Runas -ArgumentList $silentArgs

    $silentScript = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\silent.ps1"

    Start-ChocolateyProcessAsAdmin "& `'$silentScript`'"

    Write-ChocolateySuccess $packageName
}   catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}