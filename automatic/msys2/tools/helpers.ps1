$pp = Get-PackageParameters

$is64 = (Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true'
$dir_name = if ($is64) { 'msys64' } else { 'msys32' }
if (!$pp.InstallDir) { $pp.InstallDir = "{0}\{1}" -f (Get-ToolsLocation), $dir_name  }
$pp | Export-Clixml $toolsPath\pp.xml
$InstallPath = $pp.InstallDir

function Invoke-Msys2Shell($Arguments) {
    if (![string]::IsNullOrWhiteSpace($Arguments)) { $Arguments += "; " }
    $Arguments += "ps -ef | grep '[?]' | awk '{print `$2}' | xargs -r kill"

    $params = @{
        FilePath     = Join-Path $InstallPath msys2_shell.cmd
        NoNewWindow  = $true
        Wait         = $true
        ArgumentList = "-defterm", "-no-start", "-c", "`"$Arguments`""
    }
    Write-Host "Invoking msys2 shell command:" $params.ArgumentList
    Start-Process @params
}

#  For full expected output see https://gist.github.com/majkinetor/bd5e9aa8ee6c1f55513cc67b02289fa6
function Invoke-Msys2ShellFirstRun { 
    Write-Host "Invoking first run to setup things like bash profile, gpg etc..."
    Invoke-Msys2Shell    
}

function Update-MSys2 {
    if ($pp.NoUpdate) {
        Write-Host "Skipping updates due to the 'NoUpdate' option"    
        return 
    }

    $logPath      = Join-Path $InstallPath update.log
    $stopSentence = 'there is nothing to do'
    $cntSentence  = 2
    $shellArgs    = "pacman --noconfirm -Syuu | tee -a /update.log"
    $max          = 5  

    Write-Host "Repeating system update until there are no more updates or max $max iterations"
    Write-Host "Output is recorded in: $logPath"

    rm $logPath -ea 0
    $ErrorActionPreference = 'Continue'     #otherwise bash warnings will exit
    while (!$done) {
        Write-Host "`n================= SYSTEM UPDATE $((++$i)) =================`n"
        Invoke-Msys2Shell $shellArgs
        $done = (Get-Content $logPath) -match $stopSentence | Measure-Object | ForEach-Object { $_.Count -ge $cntSentence }
        $done = $done -or ($i -ge $max)
    }
}

# requires $pp.InstallDir & toolsPath in upper scope
function Install-Msys2 {
    if (Test-Path $InstallPath) { 
        Write-Host "'$InstallPath' already exists and will only be updated."
        return 
    }

    Write-Host "Installing to:" $InstallPath
    $packageArgs = @{
        PackageName    = $Env:ChocolateyPackageName
        FileFullPath   = Get-Item $ToolsPath\*-i686*
        FileFullPath64 = Get-Item $ToolsPath\*-x86_64*
        Destination    = $InstallPath
    }
    Get-ChocolateyUnzip @packageArgs
    Remove-Item $ToolsPath\*.xz -ea 0

    $tarFile = Get-Item "$InstallPath\*.tar"
    Get-ChocolateyUnzip $tarFile $InstallPath
    Remove-Item "$InstallPath\*.tar" -ea 0
    $tardir = Get-Item "$InstallPath\msys*"
    if ([String]::IsNullOrWhiteSpace($tardir)) { throw "Can't find msys* directory from tar archive" }
    Move-Item $tardir\* $InstallPath
    Remove-Item $tardir
}

function Set-Msys2Proxy {
    $proxy = Get-EffectiveProxy
    if (!$proxy) { return }
    
    Write-Host "Using CLI proxy:" $proxy
    $Env:http_proxy = $Env:https_proxy = $proxy
}
