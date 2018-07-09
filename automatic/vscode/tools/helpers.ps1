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
  $args = @()

  if (Get-Command 'code.cmd' -ErrorAction SilentlyContinue) {
    $code = $(Get-Command 'code.cmd').Source
  }
  elseif (Test-Path "${env:ProgramFiles}\Microsoft VS Code\Code.exe") {
    $code = "${env:ProgramFiles}\Microsoft VS Code\Code.exe"
    $args += "`"${env:ProgramFiles}\Microsoft VS Code\resources\app\out\cli.js`""
  }
  elseif (Test-Path "${env:ProgramFiles(x86)}\Microsoft VS Code\Code.exe") {
    $code = "${env:ProgramFiles(x86)}\Microsoft VS Code\Code.exe"
    $args += "`"${env:ProgramFiles(x86)}\Microsoft VS Code\resources\app\out\cli.js`""
  }
  if ($code) {
    if ($code.Contains('exe')) {
      $ENV:ELECTRON_RUN_AS_NODE = 1
    }
    $args += ' --version'
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = "$code"
    $pinfo.RedirectStandardError = $true
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = $args
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
    else {
      return 0
    }
  }
}
