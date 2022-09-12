function Get-InstallDir()
{
  if ($pp['InstallDir']) {
    Write-Debug '/InstallDir found.'
    return $pp['InstallDir']
  }
  return Get-ToolsLocation
}

function Get-Statement()
{
  $options      = '-create-batfiles vim gvim evim view gview vimdiff gvimdiff vimtutor -install-openwith -add-start-menu'
  $createvimrc  = '-create-vimrc -vimrc-remap no -vimrc-behave default -vimrc-compat all'
  $installpopup = '-install-popup'
  $installicons = '-install-icons'
  if ($pp['RestartExplorer'] -eq 'true') {
    Write-Debug '/RestartExplorer found.'
    Get-Process explorer | Stop-Process -Force
  }
  if ($pp['NoDefaultVimrc'] -eq 'true') {
    Write-Debug '/NoDefaultVimrc found.'
    $createvimrc = ''
  }
  if ($pp['NoContextmenu'] -eq 'true') {
    Write-Debug '/NoContextmenu found.'
    $installpopup = ''
  }
  if ($pp['NoDesktopShortcuts'] -eq 'true') {
    Write-Debug '/NoDesktopShortcuts found.'
    $installicons = ''
  }
  return $options, $createvimrc, $installpopup, $installicons -join ' '
}

# Replace old ver dir with symlink
# Use mklink because New-Item -ItemType SymbolicLink doesn't work in test-env
# Use rmdir because Powershell cannot unlink directory symlink
function Create-SymbolicLink()
{
  Get-ChildItem -Path "$installDir\vim" -Exclude "vim$shortversion" -Attributes Directory+!ReparsePoint | ForEach-Object { Remove-Item $_ -Recurse ; New-Item -Path $_ -ItemType Directory }
  Get-ChildItem -Path "$installDir\vim" -Exclude "vim$shortversion" -Attributes Directory | ForEach-Object { $_.Name } | ForEach-Object { cmd /c rmdir "$installDir\vim\$_" ; cmd /c mklink /d "$installDir\vim\$_"  "$installDir\vim\vim$shortversion" }
}
