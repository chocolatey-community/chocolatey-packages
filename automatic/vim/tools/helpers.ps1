function Get-Statement($params)
{
  $options      = '-create-batfiles vim gvim evim view gview vimdiff gvimdiff -install-openwith -add-start-menu'
  $createvimrc  = '-create-vimrc -vimrc-remap no -vimrc-behave default -vimrc-compat all'
  $installpopup = '-install-popup'
  $installicons = '-install-icons'
  if ($params['RestartExplorer'] -eq 'true') {
    Write-Debug '/RestartExplorer found.'
    Get-Process explorer | Stop-Process -Force
  }
  if ($params['NoDefaultVimrc'] -eq 'true') {
    Write-Debug '/NoDefaultVimrc found.'
    $createvimrc = ''
  }
  if ($params['NoContextmenu'] -eq 'true') {
    Write-Debug '/NoContextmenu found.'
    $installpopup = ''
  }
  if ($params['NoDesktopShortcuts'] -eq 'true') {
    Write-Debug '/NoDesktopShortcuts found.'
    $installicons = ''
  }
  return $options, $createvimrc, $installpopup, $installicons -join ' '
}
function Set-NoShim()
{
  $noshimfiles = 'diff', 'gvim', 'install', 'tee', 'uninstal', 'vim', 'vimrun', 'winpty-agent', 'xxd'
  foreach ($noshimfile in $noshimfiles) {
    New-Item "$toolsDir\vim\vim$shortversion\$noshimfile.exe.ignore" -type file -force | Out-Null
  }
}
