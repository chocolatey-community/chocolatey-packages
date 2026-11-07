$ErrorActionPreference = 'Stop'

# ffmpeg-shared is a portable archive package with no uninstall entry; Chocolatey removes the files and shims itself.
# No FFmpeg binary may be running from the package folder or it cannot be deleted.
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
Get-Process -Name 'ffmpeg', 'ffprobe', 'ffplay' -ErrorAction SilentlyContinue |
  Where-Object { $_.Path -and $_.Path.StartsWith($toolsDir + '\', [StringComparison]::OrdinalIgnoreCase) } |
  Stop-Process -Force
