$packageName = 'ffmpeg'
$url = 'http://ffmpeg.zeranoe.com/builds/win32/shared/ffmpeg-2.1.4-win32-shared.7z'
$url64 = 'http://ffmpeg.zeranoe.com/builds/win64/shared/ffmpeg-2.1.4-win64-shared.7z'

try {
    $destinationFolder = "$env:SystemDrive\tools\ffmpeg"

    if (-not(Test-Path $destinationFolder)) {
        New-Item -ItemType directory -Path $destinationFolder -Force
    }

    $downloadFile = Join-Path $env:TEMP "$packageName.7z"
    Get-ChocolateyWebFile $packageName $downloadFile $url $url64

    Start-Process "7za" -ArgumentList "x -o`"$destinationFolder`" -y `"$downloadFile`"" -Wait

    $content = (Get-ChildItem $destinationFolder).Name
    $hasMatched = $content -match '^ffmpeg-[\d\.]+-win[36][24]-shared$'

    if ($hasMatched -match '^ffmpeg-[\d\.]+-win[36][24]-shared$') {
        $subFolder = $hasMatched
    } else {
        $subFolder = $Matches[0]
    }

    Copy-Item "$destinationFolder\$subFolder\*" $destinationFolder -Recurse -Force
    Remove-Item "$destinationFolder\$subFolder" -Recurse -Force
    Remove-Item $downloadFile

    


    function pathEnvMatch($userOrMachine) {
        $pathEnv = [environment]::GetEnvironmentVariable("Path",$userOrMachine)
        $alreadyInPath = $env:Path -match "$env:SystemDrive\\tools\\ffmpeg\\bin"
        if ($alreadyInPath) {
            Write-Host "No need to add ffmpeg\bin to Path, because it’s already there"
        }
        return $alreadyInPath
    }

    if (-not($alreadyInPath)) {
        $isAdmin = ([Security.Principal.WindowsPrincipal]`
        [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] “Administrator”)

        if ($isAdmin) {
            if (-not(pathEnvMatch 'Machine')) {
                Write-Host 'Adding ffmpeg\bin to Admin path'
                Install-ChocolateyPath "$destinationFolder\bin" 'Machine'
            }
        } else {
            if (-not(pathEnvMatch 'User')) {
                Write-Host 'Adding ffmpeg\bin to User path'
                Install-ChocolateyPath "$destinationFolder\bin"
            }
        }
    }

    # Remove previous and now obsolete links from the Chocolatey\bin folder
    $oldLinkFiles = @('ffmpeg', 'ffplay', 'ffprobe')
    $chocoBinPath = Join-Path $env:ChocolateyInstall '/bin'

    foreach ($name in $oldLinkFiles) {
        $filePath = Join-Path $chocoBinPath $name
        if (Test-Path $filePath) {
            Remove-Item $filePath
        }

        if (Test-Path "${filePath}.bat") {
            Remove-Item "${filePath}.bat"
        }
    }

    Write-ChocolateySuccess $packageName
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
