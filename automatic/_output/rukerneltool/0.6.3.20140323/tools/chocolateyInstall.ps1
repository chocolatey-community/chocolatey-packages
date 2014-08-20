try {

    $packageName = 'rukerneltool'
    $file = Join-Path $env:TEMP "${packageName}.zip"
    $url = 'http://rukerneltool.rainerullrich.de/download2/ruKernelTool.zip'

    if (Test-Path $file) {
        Remove-Item $file
    }

    Start-Process 'wget' -NoNewWindow -Wait -ArgumentList $url, "-O `"$file`"", '--user=ruKernelTool2', '--password=Bommelchen_2010'

    & 7za x -o"$env:HOMEDRIVE" -y "$file"
    Remove-Item $file

    Write-ChocolateySuccess $packageName

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}