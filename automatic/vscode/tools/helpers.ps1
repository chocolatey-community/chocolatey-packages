function Get-MergeTasks {
    $t  = "!runCode"
    $t += ', ' + '!'*$pp.NoDesktopIcon        + 'desktopicon'
    $t += ', ' + '!'*$pp.NoQuicklaunchIcon    + 'quicklaunchicon'
    $t += ', ' + '!'*$pp.NoContextMenuFiles   + 'addcontextmenufiles'
    $t += ', ' + '!'*$pp.NoContextMenuFolders + 'addcontextmenufolders'
    $t += ', ' + '!'*$pp.DontAddToPath        + 'addtopath'

    Write-Host "Merge Tasks: $t"
    $t
}

function Close-VSCode {
    Get-Process code -ea 0 | ForEach-Object { $_.CloseMainWindow() | Out-Null }
    Start-Sleep 1
    Get-Process code -ea 0 | Stop-Process  #in case gracefull shutdown did not succeed, try hard kill
}