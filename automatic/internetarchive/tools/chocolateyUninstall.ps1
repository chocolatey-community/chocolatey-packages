$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Uninstall-BinFile -Name 'ia'

# Let uv remove its own tool environment and shim. The package directory is
# removed by Chocolatey afterwards, so a missing uv is not an error.
$uv = Get-Command uv -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
if ($uv) {
  $env:UV_PYTHON_INSTALL_DIR = Join-Path $toolsDir 'python'
  $env:UV_TOOL_DIR           = Join-Path $toolsDir 'tool'
  $env:UV_TOOL_BIN_DIR       = Join-Path $toolsDir 'bin'
  $env:UV_CACHE_DIR          = Join-Path $toolsDir 'cache'
  $env:UV_NO_PROGRESS        = '1'
  $env:UV_NO_CONFIG          = '1'

  # Merge stderr through cmd.exe so Chocolatey does not treat uv's output as a
  # terminating error.
  & cmd.exe /d /c 'uv tool uninstall internetarchive 2>&1'
  if ($LASTEXITCODE -ne 0) {
    Write-Warning "uv tool uninstall failed with exit code $LASTEXITCODE."
  }
}
