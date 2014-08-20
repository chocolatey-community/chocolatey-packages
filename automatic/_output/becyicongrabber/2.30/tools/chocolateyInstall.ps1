try {
    $packageName = 'becyicongrabber'
    $unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
    $url = 'http://www.becyhome.de/download/BeCyIGrab230Eng.zip'

    $language = (Get-Culture).Parent.Name
    if ($language -eq 'de') {$url = $url -replace 'Eng(\.zip)', 'Ger$1'}

    Install-ChocolateyZipPackage $packageName $url $unzipLocation

}   catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw 
}