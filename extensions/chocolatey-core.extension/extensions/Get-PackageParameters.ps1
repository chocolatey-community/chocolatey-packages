<#
.SYNOPSIS
    Parses parameters of the package

.EXAMPLE
    Get-PackageParameters "/Shortcut /InstallDir:'c:\program files\xyz' /NoStartup" | set r
    if ($r.Shortcut) {... }
    Write-Host $r.InstallDir

.OUTPUTS
    [HashTable]
#>
function Get-PackageParameters([string] $Parameters = $Env:ChocolateyPackageParameters) {
    $res = @{}
    $re = "\/([a-zA-Z]+)(:([`"'])?([a-zA-Z0-9- _\\:\.]+)([`"'])?)?"
    $results = $Parameters | Select-String $re -AllMatches | select -Expand Matches
    foreach ($m in $results) {
        $a = $m.Value -split ':'
        $opt = $a[0].Substring(1); $val = $a[1..100]
        if ($val -match '^(".+")|(''.+'')$') {$val = $val -replace '^.|.$'}
        $res[ $opt ] = if ($val) { $val } else { $true }
    }
    $res
}
