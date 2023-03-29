function Set-TCShellExtension() {
    Write-Host "Setting shell extension"

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ErrorAction SilentlyContinue | Out-Null
    #sp HKCR:\Directory\shell -name "(Default)" -Value "Total_Commander"
    New-Item -Path 'HKCR:\Directory\shell\Total_Commander\command' -Force | Out-Null
    Set-ItemProperty 'HKCR:\Directory\shell\Total_Commander' -Name '(Default)' -Value 'Total Commander'
    Set-ItemProperty 'HKCR:\Directory\shell\Total_Commander\command'  -Name '(Default)' -Value "$installLocation\$tcExeName /O ""%1"""
}

function Remove-TCShellExtension {
    Write-Host 'Removing shell extension, if added.'

    New-PSDrive -Name 'HKCR' -PSProvider Registry -Root 'HKEY_CLASSES_ROOT' -ErrorAction SilentlyContinue | Out-Null
    Remove-Item -Path 'HKCR:\Directory\shell\Total_Commander' -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
}

function Set-ExplorerAsDefaultFM {
    Write-Host 'Setting Explorer as default File Manager.'

    New-PSDrive -Name 'HKCR' -PSProvider Registry -Root 'HKEY_CLASSES_ROOT' -ErrorAction SilentlyContinue | Out-Null

    $key = Get-ItemProperty -Path 'HKCR:\Directory\shell\open\command' -Name '(default)'
    if ($key.'(default)' -match 'totalcmd.exe /O "%1"$') {
      Write-Host "Removing Total Commander as default File Manager for directories."
      Remove-Item -Path $key.PSParentPath -Recurse -ErrorAction SilentlyContinue | Out-Null
    }

  $key = Get-ItemProperty -Path 'HKCR:\Drive\shell\open\command' -Name '(default)'
  if ($key.'(default)' -match 'totalcmd.exe /O "%1"$') {
    Write-Host "Removing Total Commander as default File Manager for drives."
    Remove-Item -Path $key.PSParentPath -Recurse -ErrorAction SilentlyContinue | Out-Null
  }
}

function Set-TCAsDefaultFM {
    Write-Host "Setting Total Commander as default file manager."

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ErrorAction SilentlyContinue | Out-Null

    Set-ItemProperty 'HKCR:\Drive\shell' -Name '(Default)' -Value 'open'
    New-Item -Path 'HKCR:\Drive\shell\open\command' -Force | Out-Null
    Set-ItemProperty 'HKCR:\Drive\shell\open\command'  -Name '(Default)' -Value "$installLocation\$tcExeName /O ""%1"""

    Set-ItemProperty 'HKCR:\Directory\shell' -Name '(Default)' -Value 'open'
    New-Item -Path 'HKCR:\Directory\shell\open\command' -Force | Out-Null
    Set-ItemProperty 'HKCR:\Directory\shell\open\command' -Name '(Default)' -Value "$installLocation\$tcExeName /O ""%1"""
}

function Get-TCInstallLocation {
    if ($env:COMMANDER_PATH) {
      return $env:COMMANDER_PATH
    }

    $key = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Ghisler\Total Commander' -ErrorAction SilentlyContinue
    if ($key) {
      return $key.InstallDir
    }

    $installLocation = Get-AppInstallLocation -AppNamePattern 'totalcmd'
    if ($installLocation) {
      return $installLocation
    }

    $localPath = Join-Path -Path $env:SystemDrive -ChildPath 'totalcmd'
    if (Test-Path -Path $localPath) {
      return $localPath
    }
}

function Set-TCIniFilesLocation {
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Ghisler\Total Commander' -Name 'IniFileName' -Value '%COMMANDER_PATH%\wincmd.ini'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Ghisler\Total Commander' -Name 'FtpIniName' -Value '%COMMANDER_PATH%\wcx_ftp.ini'
}
