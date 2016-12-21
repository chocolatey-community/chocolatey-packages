function Get-InstallKey() {
    $registryKeyName = 'Git_is1'
    $installKey = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryKeyName"
    if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
        $installKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$registryKeyName"
    }

    $userInstallKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$registryKeyName"
    if (Test-Path $userInstallKey) {
        $installKey = $userInstallKey
    }

    return $installKey
}

function Set-InstallerSettings([string] $InstallKey, [bool] $GitOnlyOnPath, [bool] $WindowsTerminal, [bool] $GitAndUnixToolsOnPath, [bool] $NoAutoCrlf) {
    if (-not (Test-Path $InstallKey)) {
        New-Item -Path $InstallKey | Out-Null
    }

    if ($GitOnlyOnPath) {
        # update registry so installer picks it up automatically
        New-ItemProperty $InstallKey -Name "Inno Setup CodeFile: Path Option" -Value "Cmd" -PropertyType "String" -Force | Out-Null
    }

    if ($WindowsTerminal) {
        # update registry so installer picks it up automatically
        New-ItemProperty $InstallKey -Name "Inno Setup CodeFile: Bash Terminal Option" -Value "ConHost" -PropertyType "String" -Force | Out-Null
    }

    if ($GitAndUnixToolsOnPath) {
        # update registry so installer picks it up automatically
        New-ItemProperty $InstallKey -Name "Inno Setup CodeFile: Path Option" -Value "CmdTools" -PropertyType "String" -Force | Out-Null
    }

    if ($NoAutoCrlf) {
        # update registry so installer picks it up automatically
        New-ItemProperty $InstallKey -Name "Inno Setup CodeFile: CRLF Option" -Value "CRLFCommitAsIs" -PropertyType "String" -Force | Out-Null
    }    
}

function Remove-QuickLaunchForSystemUser([string] $FileArgs) {
    # Make our install work properly when running under SYSTEM account (Chef Cliet Service, Puppet Service, etc)
    # Add other items to this if block or use $IsRunningUnderSystemAccount to adjust existing logic that needs changing
    $IsRunningUnderSystemAccount = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem
    If ($IsRunningUnderSystemAccount)
    {
        #strip out quicklaunch parameter as it causes a hang under SYSTEM account
        $FileArgs = $FileArgs.Replace('icons\quicklaunch,','')
        If ($FileArgs -inotlike "*/SUPPRESSMSGBOXES*")
        {
            $FileArgs = $FileArgs + ' /SUPPRESSMSGBOXES'
        }
    }    
    return $FileArgs
}

function Stop-GitSSHAgent() {
    If ([bool](Get-Process ssh-agent -ErrorAction SilentlyContinue))
    {
        Write-Output "Killing any Git ssh-agent instances for install."
        (Get-Process ssh-agent | Where-Object {$_.Path -ilike "*\git\usr\bin\*"}) | Stop-Process
    }    
}