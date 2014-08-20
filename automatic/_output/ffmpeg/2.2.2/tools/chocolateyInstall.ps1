$packageName = 'ffmpeg'
$url = 'http://ffmpeg.zeranoe.com/builds/win32/shared/ffmpeg-2.2.2-win32-shared.7z'
$url64 = 'http://ffmpeg.zeranoe.com/builds/win64/shared/ffmpeg-2.2.2-win64-shared.7z'

try {

    $deprecatedDestinationFolder = Join-Path $env:SystemDrive 'tools\ffmpeg'
    
    if ($env:ChocolateyBinRoot) {
        $destinationFolder = Join-Path $env:ChocolateyBinRoot 'ffmpeg'
    } else {
        $destinationFolder = $deprecatedDestinationFolder
    }

    if ((Test-Path $deprecatedDestinationFolder) -and ($deprecatedDestinationFolder -ne $destinationFolder)) {

        $destinationFolder = $deprecatedDestinationFolder

        Write-Output @"
Warning: Deprecated installation folder detected: %SystemDrive%\tools\ffmpeg.
This package will continue to install ffmpeg there unless you remove the deprecated installation folder.
After you did that, reinstall this package again with the “-force” parameter. Then it will use %ChocolateyBinRoot%\ffmpeg.
"@

    }

    $subFolder = $url -replace '.+\/(.+)\..+', '$1'

    Install-ChocolateyZipPackage $packageName $url $destinationFolder $url64

    if ((Get-ChildItem $destinationFolder).Name -contains $subFolder) {
        # do nothing
    } else {
        $subFolder = $url64 -replace '.+\/(.+)\..+', '$1'
    }

    $subFolderPath = Join-Path $destinationFolder $subFolder

    Copy-Item -Force -Recurse -Path "$subFolderPath\*" -Destination $destinationFolder
    Remove-Item -Recurse $subFolderPath

    # Should this package really add the ffmpeg\bin folder to PATH?
    # Install-ChocolateyPath "$destinationFolder\bin"

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}