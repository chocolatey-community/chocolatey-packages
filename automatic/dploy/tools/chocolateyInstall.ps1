$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version  = '0.2.0'

if (-not [Environment]::Is64BitOperatingSystem) {
  throw 'The dploy package requires a 64-bit version of Windows.'
}

$uv = Get-Command uv -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $uv) {
  throw 'uv was not found. The uv package is required to install dploy.'
}

# Keep everything uv creates inside the package directory. This way the managed
# Python interpreter, the virtual environment and the tool shim are all removed
# when the package is uninstalled.
$env:UV_PYTHON_INSTALL_DIR = Join-Path $toolsDir 'python'
$env:UV_TOOL_DIR           = Join-Path $toolsDir 'tool'
$env:UV_TOOL_BIN_DIR       = Join-Path $toolsDir 'bin'
$env:UV_CACHE_DIR          = Join-Path $toolsDir 'cache'
$env:UV_LINK_MODE          = 'copy'
$env:UV_NO_PROGRESS        = '1'
$env:UV_NO_CONFIG          = '1'

# uv writes progress information to stderr. Merge both streams through cmd.exe
# so that Chocolatey does not treat the progress output as a terminating error.
function Invoke-Uv {
  param(
    [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
    [string[]]$Arguments
  )

  $command = 'uv {0} 2>&1' -f ($Arguments -join ' ')
  & cmd.exe /d /c $command
  if ($LASTEXITCODE -ne 0) {
    throw "uv $($Arguments[0]) failed with exit code $LASTEXITCODE."
  }
}

$proxy = Get-EffectiveProxy
if ($proxy) {
  Write-Host "Setting CLI proxy: $proxy"
  $env:http_proxy = $env:https_proxy = $proxy
}

Invoke-Uv python install 3.12 --no-bin --no-registry
Invoke-Uv tool install "dploy==$version" --python 3.12 --managed-python --force

$dployExe = Join-Path $env:UV_TOOL_BIN_DIR 'dploy.exe'
if (-not (Test-Path $dployExe)) {
  throw "The dploy executable was not created at '$dployExe'."
}

Install-BinFile -Name 'dploy' -Path $dployExe

# The cache is only needed while installing.
try {
  Invoke-Uv cache clean --quiet
} catch {
  Write-Warning "Failed to clean the uv cache: $_"
}

# Chocolatey automatically shims every executable it finds in the package
# folder. Ignore all of them so that only the explicit dploy shim above is
# created and the managed python.exe does not end up on the PATH.
Get-ChildItem -Path $toolsDir -Filter '*.exe' -Recurse | Where-Object {
  -not $_.PSIsContainer
} | ForEach-Object {
  New-Item -Path "$($_.FullName).ignore" -ItemType File -Force | Out-Null
}
