$ErrorActionPreference = 'Stop'
$toolsPath = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

# Remove shims added for .bat and .cmd files, in the Ruby bin folder
$rubyDir = Join-Path -Path $toolsPath -ChildPath 'ruby\ruby*\bin\'
'*.bat', '*.cmd' | ForEach-Object {
  Get-ChildItem -Path (Join-Path -Path $rubyDir -ChildPath $_) | ForEach-Object {
    Uninstall-BinFile -Name $_.BaseName -Path $_.FullName
  }
}
