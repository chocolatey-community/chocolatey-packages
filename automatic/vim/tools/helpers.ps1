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
  $options      = '-create-batfiles vim gvim evim view gview vimdiff gvimdiff -install-openwith -add-start-menu'
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
