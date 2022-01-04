﻿function Get-InstallOptions( [HashTable]$pp )
{
    # Options are defined in this [file](https://github.com/git-for-windows/build-extra/blob/main/installer/install.iss)
    # You can see [here](https://github.com/git-for-windows/build-extra/blob/4490974c504f1bbc07327b885ea3607ad019f736/installer/install.iss#L1140) how they are interpreted, it is all parameters passed in the ReplayChoice method without spaces.
    $options = @()
    if ($pp.GitOnlyOnPath)             { $options += "/o:PathOption=Cmd" }
    elseif ($pp.GitAndUnixToolsOnPath) { $options += "/o:PathOption=CmdTools" }
    if ($pp.WindowsTerminal)           { $options += "/o:BashTerminalOption=ConHost" }
    if ($pp.NoAutoCrlf)                { $options += "/o:CRLFOption=CRLFCommitAsIs" }
    if ($pp.SChannel)                  { $options += "/o:CURLOption=WinSSL" }
    if ($pp.NoOpenSSH)                 { $options += "/o:SSHOption=ExternalOpenSSH" }
    if ($pp.Symlinks)                  { $options += "/o:EnableSymlinks=Enabled" }
    if ($pp.DefaultBranchName)         { $options += "/o:DefaultBranchOption=" + $pp.DefaultBranchName }
    if ($pp.PseudoConsoleSupport)      { $options += "/o:EnablePseudoConsoleSupport=Enabled" }
    if ($pp.FSMonitor)                 { $options += "/o:EnableFSMonitor=Enabled" }

    if($pp.Editor)
    {
      if ($pp.Editor -in @('Atom', 'Nano', 'Notepad', 'Notepad++', 'SublimeText', 'VIM', 'VisualStudioCode', 'VisualStudioCodeInsiders', 'VSCodium', 'Wordpad'))
      {
        $options += "/o:EditorOption=" + $pp.Editor
      }
      else {
        $options += "/o:EditorOption=CustomEditor"
        $options += "/o:CustomEditorPath=" + $pp.Editor
      }
    }
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

    if ($pp.WindowsTerminalProfile ) { $res += "windowsterminal" }

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
