try {

    $packageName = 'ontopreplica'
    $silentArgs = '/S'
    $url = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=ontopreplica&DownloadId=780725&FileTime=130345325848130000&Build=20859'
    $fileFullPath = Join-Path $env:TEMP 'ontopreplicaInstall.exe'

    Get-ChocolateyWebFile $packageName $fileFullPath $url
    Start-Process $fileFullPath -ArgumentList $silentArgs -Wait
    Remove-Item $fileFullPath

    Write-ChocolateySuccess $packageName

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}