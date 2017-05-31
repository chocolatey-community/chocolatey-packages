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
