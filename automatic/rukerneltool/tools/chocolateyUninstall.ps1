$packageName = '{{PackageName}}'

$desktop = "$([Environment]::GetFolderPath("Desktop"))"
$startMenu = "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))\Programs"

$installDir1 = Join-Path $env:SystemDrive 'ruKernelTool'
$installDir2 = Join-Path $env:SystemDrive 'tools\ruKernelTool'
$installDir3 = Join-Path $env:ChocolateyBinRoot 'ruKernelTool'
$shortcut1 = Join-Path $desktop 'ruKernelTool.lnk'
$shortcut2 = Join-Path $startMenu 'ruKernelTool.lnk'
$possibleItemsToRemove = @($installDir1, $installDir2, $installDir3, $shortcut1, $shortcut2)

foreach ($itemToRemove in $possibleItemsToRemove) {
  if (Test-Path $itemToRemove) {
    Remove-Item -Recurse -Force $itemToRemove
  }
}
