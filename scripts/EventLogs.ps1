#require -version 3.0

<#
.SYNOPSIS
    Clear all event logs
#>
function Clear-EventLogs {
    Get-EventLog * | % { Clear-EventLog $_.Log }

    #Clear this one again as it accumulates clearing events from previous step
    Clear-EventLog System
    Get-EventLog *
}

<#
.SYNOPSIS
    Get latest event logs across all event logs
.Example
    logs Error,Warning -Newest 5
#>
function Get-EventLogs{
    param(
        [ValidateSet('Error', 'Information', 'Warning', '*')]
        [string[]] $EntryType = 'Error',

        [int] $Newest=1000,

        [switch] $Raw
    ) 
    $r = @()

    if ($EntryType -eq '*') { $EntryType = 'Error', 'Information', 'Warning' }
    Get-EventLog * | % Log | % {
        $log = $_
        try {
            $r += Get-EventLog -Log $log -Newest $Newest -EntryType $EntryType -ea 0
        }
        catch { Write-Warning "$log - $_" }
    }
    $r = $r | sort TimeWritten -Descending 
    if ($Raw) {$r} else { $r | select Source, TimeWritten, Message }
}

sal logs Get-EventLogs
sal clearlogs Clear-EventLogs
