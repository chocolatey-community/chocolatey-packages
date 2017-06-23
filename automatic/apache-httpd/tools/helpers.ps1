function Assert-TcpPortIsOpen {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][int] $portNumber
    )

    $process = Get-NetTCPConnection -State Listen -LocalPort $portNumber -ErrorAction SilentlyContinue | `
        Select-Object -First 1 -ExpandProperty OwningProcess | `
        Select-Object @{Name = "Id"; Expression = {$_} } | `
        Get-Process | `
        Select-Object Name, Path

    if ($process) {
        if ($process.Path) {
            Write-Host "Port '$portNumber' is in use by '$($process.Name)' with path '$($process.Path)'..."
        }
        else {
            Write-Host "Port '$portNumber' is in use by '$($process.Name)'..."
        }

        return $false
    }

    return $true
}

function Get-ApacheInstallOptions {
    $configFile = Join-Path $env:chocolateyPackageFolder 'config.xml'
    $config = Import-CliXml $configFile

    return $config
}

function Get-ApachePaths {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)][ValidateNotNullOrEmpty()][string] $installDir
    )

    $apacheDir = Get-ChildItem $installDir -Directory -Filter 'Apache*' | Select-Object -First 1 -ExpandProperty FullName
    $confPath = Join-Path $apacheDir 'conf\httpd.conf'
    $binPath = Join-Path $apacheDir 'bin\httpd.exe'

    return @{ ApacheDir = $apacheDir; ConfPath = $confPath; BinPath = $binPath }
}

function Install-Apache {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)][ValidateNotNullOrEmpty()][PSCustomObject] $arguments
    )

    Get-ChocolateyUnzip `
        -file $arguments.file `
        -file64 $arguments.file64 `
        -destination $arguments.destination

    Set-ApacheConfig $arguments

    Install-ApacheService $arguments

    Set-ApacheInstallOptions $arguments
}

function Install-ApacheService {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)][ValidateNotNullOrEmpty()][PSCustomObject] $arguments
    )

    $apachePaths = Get-ApachePaths $arguments.destination

    & $apachePaths.BinPath -k install -n "$($arguments.serviceName)"

    Start-Service $arguments.serviceName
}

function Set-ApacheConfig {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)][ValidateNotNullOrEmpty()][PSCustomObject] $arguments
    )

    $apachePaths = Get-ApachePaths $arguments.destination

    # Set the server root and port number
    $httpConf = Get-Content $apachePaths.ConfPath
    $httpConf = $httpConf -replace 'Define SRVROOT.*', "Define SRVROOT ""$($apachePaths.ApacheDir -replace '\\', '/')"""
    $httpConf = $httpConf -replace 'Listen 80', "Listen $($arguments.port)"

    Set-Content -Path $apachePaths.ConfPath -Value $httpConf -Encoding Ascii
}

function Set-ApacheInstallOptions {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)][ValidateNotNullOrEmpty()][PSCustomObject] $arguments
    )

    $apachePaths = Get-ApachePaths $arguments.destination

    $config = @{
        Destination = $apachePaths.ApacheDir
        BinPath   = $apachePaths.BinPath
        ServiceName = $arguments.serviceName
    }

    $configFile = Join-Path $env:chocolateyPackageFolder 'config.xml'
    Export-Clixml -Path $configFile -InputObject $config
}

function Stop-ApacheService {
    $config = Get-ApacheInstallOptions

    $service = Get-Service | Where-Object Name -eq $config.serviceName

    if ($service) {
        Stop-Service $config.serviceName
    }
}

function Uninstall-Apache {
    $config = Get-ApacheInstallOptions

    & $config.BinPath -k uninstall -n "$($config.serviceName)"

    Remove-Item $config.destination -Recurse -Force
}

function Uninstall-ApacheService {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)][ValidateNotNullOrEmpty()][PSCustomObject] $arguments
    )

    $apachePaths = Get-ApachePaths $arguments.destination

    & $apachePaths.BinPath -k uninstall -n "$($arguments.serviceName)"
}
