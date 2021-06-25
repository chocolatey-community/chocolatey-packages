$ErrorActionPreference = 'Stop'

$gui = 'Octave.lnk'
$cli = 'Octave CLI.lnk'

$desktop         = [Environment]::GetFolderPath('Desktop')
$commonDesktop   = [Environment]::GetFolderPath('CommonDesktopDirectory')
$startMenu       = [Environment]::GetFolderPath('StartMenu')
$commonStartMenu = [Environment]::GetFolderPath('CommonStartMenu')

$paths = @(
  (Join-Path $desktop $gui),
  (Join-Path $desktop $cli),
  (Join-Path $commonDesktop $gui),
  (Join-Path $commonDesktop $cli),
  (Join-Path $startMenu 'Octave' | Join-Path -ChildPath $gui),
  (Join-Path $startMenu 'Octave' | Join-Path -ChildPath $cli),
  (Join-Path $commonStartMenu 'Octave' | Join-Path -ChildPath $gui)
  (Join-Path $commonStartMenu 'Octave' | Join-Path -ChildPath $cli)
)

# Remove any shortcuts
$paths.GetEnumerator() | ForEach-Object {
  if (Test-Path -Path $_) {
    Remove-Item $_ -ErrorAction SilentlyContinue -Force | Out-Null
  }
}
