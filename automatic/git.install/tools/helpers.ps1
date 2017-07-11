function Get-InstallKey()
{
    $keyName = 'Git_is1'
    $installKey = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -eq 'true') {
             "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$keyName"
    } else { "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$keyName" }

    $userInstallKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$keyName"
    if (Test-Path $userInstallKey) { $installKey = $userInstallKey }

    mkdir $installKey -ea 0 | Out-Null
    $installKey
}

function Set-InstallerRegistrySettings( [HashTable]$pp )
{
    $installkey = Get-InstallKey
    $ino = "Inno Setup CodeFile:"

    if ($pp.GitOnlyOnPath)         { New-ItemProperty $InstallKey -Name "$ino Path Option"          -Value "Cmd"            -Force }
    if ($pp.GitAndUnixToolsOnPath) { New-ItemProperty $InstallKey -Name "$ino Path Option"          -Value "CmdTools"       -Force }
    if ($pp.WindowsTerminal)       { New-ItemProperty $InstallKey -Name "$ino Bash Terminal Option" -Value "ConHost"        -Force }
    if ($pp.NoAutoCrlf)            { New-ItemProperty $InstallKey -Name "$ino CRLF Option"          -Value "CRLFCommitAsIs" -Force }
}

function Get-InstallComponents( [HashTable]$pp )
{
    $res = "icons", "assoc", "assoc_sh"

    if ($pp.NoShellIntegration) {
        Write-Host "Parameter: no git shell integration"
    } else { $res += "ext", "ext\shellhere", "ext\guihere" }

    if (!$pp.NoGitLfs) {
        Write-Host "Using Git LFS"
        $res += 'gitlfs'
    }

    # Make our install work properly when running under SYSTEM account (Chef Cliet Service, Puppet Service, etc)
    $isSystem = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem
    if ( !$isSystem ) { $res += "icons\quicklaunch" }

    if ($res.Length -eq 0) { return }
    return '/COMPONENTS="{0}"' -f ($res -join ",")
}

function Stop-GitSSHAgent()
{
    if (!(Get-Process ssh-agent -ea 0)) { return }

    Write-Host "Killing any running git ssh-agent instances"
    Get-Process ssh-agent | Where-Object {$_.Path -ilike "*\git\usr\bin\*"} | Stop-Process
}
