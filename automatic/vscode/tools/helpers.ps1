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

function Get-VSCodeVersion {
  $possiblePaths = @(
    "${env:ProgramFiles}\Microsoft VS Code\bin\code.cmd",
    "${env:ProgramFiles(x86)}\Microsoft VS Code\bin\code.cmd"
  )

  if (Get-Command 'code.cmd' -ErrorAction SilentlyContinue) {
    $possiblePaths += $(Get-Command 'code.cmd').Source
  }
  $possiblePaths | ForEach-Object {
    if (Test-Path "$_") {
      $code = "$_"
      return
    }
  }
  if ($code) {
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = "$code"
    $pinfo.RedirectStandardError = $true
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = '--version'
    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $pinfo
    try {
      $p.Start() | Out-Null
      $p.WaitForExit()
    }
    catch {
      # ignored
    }
    if ($p.ExitCode -eq 0) {
      $ver = $p.StandardOutput.ReadLine()
    }
    if ($ver) {
      return $ver
    }
  }
}
