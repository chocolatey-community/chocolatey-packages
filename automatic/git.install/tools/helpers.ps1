function Get-InstallOptions( [HashTable]$pp )
{
    $options = @()
    if ($pp.GitOnlyOnPath)             { $options += "/o:PathOption=Cmd" }
    elseif ($pp.GitAndUnixToolsOnPath) { $options += "/o:PathOption=CmdTools" }
    if ($pp.WindowsTerminal)           { $options += "/o:BashTerminalOption=ConHost" }
    if ($pp.NoAutoCrlf)                { $options += "/o:CRLFOption=CRLFCommitAsIs" }
    if ($pp.SChannel)                  { $options += "/o:CURLOption=WinSSL" }
    return $options
}

function Get-InstallComponents( [HashTable]$pp )
{
    $res = "icons", "assoc", "assoc_sh"

    $res += Get-ShellIntegrationComponents $pp

    if (!$pp.NoGitLfs) {
        Write-Host "Using Git LFS"
        $res += 'gitlfs'
    }

    # Make our install work properly when running under SYSTEM account (Chef Client Service, Puppet Service, etc)
    $isSystem = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem
    if ( !$isSystem ) { $res += "icons\quicklaunch" }

    if ($res.Length -eq 0) { return }
    return '/COMPONENTS="{0}"' -f ($res -join ",")
}

function Get-ShellIntegrationComponents( [HashTable]$pp )
{
    $shell = "ext", "ext\shellhere", "ext\guihere"
    if ($pp.NoShellIntegration) {
        Write-Host "Parameter: no git shell integration"
        $shell.Clear()
    } else {
        if ($pp.NoShellHereIntegration) {
            Write-Host "Parameter: no git bash here integration"
            $shell = $shell -ne "ext\shellhere"
        }
        if ($pp.NoGuiHereIntegration) {
            Write-Host "Parameter: no git gui here integration"
            $shell = $shell -ne "ext\guihere"
        }
        if ($shell.Count -eq 1) { $shell.Clear() }
    }

    return $shell
}

function Stop-GitSSHAgent()
{
    if (!(Get-Process ssh-agent -ea 0)) { return }

    Write-Host "Killing any running git ssh-agent instances"
    Get-Process ssh-agent | Where-Object {$_.Path -ilike "*\git\usr\bin\*"} | Stop-Process
}
