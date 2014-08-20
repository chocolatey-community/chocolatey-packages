try {

    $packageName = 'rukerneltool'
    $zipFile = 'rukerneltool.zip'
    $zipFilePath = Join-Path $env:TEMP $zipFile
    $url = 'http://rukerneltool.rainerullrich.de/download2/ruKernelTool.zip'

    $deprecatedDestinationFolder = Join-Path $env:SystemDrive 'ruKernelTool'

    if (Test-Path $deprecatedDestinationFolder) {

        $destinationFolder = $deprecatedDestinationFolder

        Write-Output @"
Warning: Deprecated installation folder detected: %SystemDrive%\ruKernelTool.
This package will continue to install rukerneltool there unless you remove the deprecated installation folder.
After you did that, reinstall this package again with the “-force” parameter. Then it will use %ChocolateyBinRoot%\ruKernelTool.
"@
    } else {
    
        if (!$env:ChocolateyBinRoot) {
            $destinationFolder = $env:ChocolateyBinRoot
        } else {

            Write-Output 'No $env:ChocolateyBinRoot detected. Will use $env:SystemDrive\tools\ruKernelTool as installation folder'
            $destinationFolder = Join-Path $env:SystemDrive 'tools'
        }
    
    }

    cd $env:TEMP
    Start-Process 'wget' -NoNewWindow -Wait -ArgumentList $url, "-O $zipFile", '--user=ruKernelTool2', '--password=Bommelchen_2010'

    Get-ChocolateyUnzip $zipFilePath $destinationFolder
    Remove-Item $zipFilePath

    Write-ChocolateySuccess $packageName

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}