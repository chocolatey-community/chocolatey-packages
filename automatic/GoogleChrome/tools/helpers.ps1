function Get-Chrome32bitInstalled {
    $registryPath = 'HKLM:\SOFTWARE\WOW6432Node\Google\Update\ClientState\'
    if (!(Test-Path $registryPath)) { return }

    gi $registryPath | % {
        if ((Get-ItemProperty $_.pspath).ap -eq '-multi-chrome') { return $true }
    }
}

function Get-ChromeVersion() {
    $root   = 'HKLM:\SOFTWARE\Google\Update\Clients'
    $root64 = 'HKLM:\SOFTWARE\Wow6432Node\Google\Update\Clients'
    foreach ($r in $root,$root64) {
        $gcb = gci $r -ea 0 | ? { (gp $_.PSPath) -match 'Google Chrome binaries' }
        if ($gcb) { return $gcb.GetValue('pv') }
    }
}
