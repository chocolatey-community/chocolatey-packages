$ErrorActionPreference = 'Stop'

# A running ffmpeg, ffprobe or ffplay locks its DLLs, so an upgrade or reinstall could not replace or remove the old folder.
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
Get-Process -Name 'ffmpeg', 'ffprobe', 'ffplay' -ErrorAction SilentlyContinue |
  Where-Object { $_.Path -and $_.Path.StartsWith($toolsDir + '\', [StringComparison]::OrdinalIgnoreCase) } |
  Stop-Process -Force
