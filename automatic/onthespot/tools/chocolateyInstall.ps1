$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version  = '1.8.1'

if (-not [Environment]::Is64BitOperatingSystem) {
  throw 'The onthespot package requires a 64-bit version of Windows.'
}

$uv = Get-Command uv -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $uv) {
  throw 'uv was not found. The uv package is required to install onthespot.'
}

# Keep everything uv creates inside the package directory. This way the managed
# Python interpreter and the virtual environment are removed when the package is
# uninstalled.
$env:UV_PYTHON_INSTALL_DIR = Join-Path $toolsDir 'python'
$env:UV_CACHE_DIR          = Join-Path $toolsDir 'cache'
$env:UV_LINK_MODE          = 'copy'
$env:UV_NO_PROGRESS        = '1'
$env:UV_NO_CONFIG          = '1'

# uv writes progress information to stderr. Merge both streams through cmd.exe
# so that Chocolatey does not treat the progress output as a terminating error.
# The arguments are joined into a single command line, so arguments containing
# spaces have to be quoted.
function Invoke-Uv {
  param(
    [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
    [string[]]$Arguments
  )

  $quoted = $Arguments | ForEach-Object { if ($_ -match '\s') { '"{0}"' -f $_ } else { $_ } }
  $command = 'uv {0} 2>&1' -f ($quoted -join ' ')
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

$venvDir    = Join-Path $toolsDir 'venv'
$venvPython = Join-Path $venvDir 'Scripts\python.exe'

Invoke-Uv python install 3.12 --no-bin --no-registry
Invoke-Uv venv $venvDir --python 3.12 --managed-python

# The project declares the onthespot-cli, onthespot-gui and onthespot-web
# console scripts, but the 1.x releases ship a pyproject.toml that takes
# precedence over setup.cfg, so the package that is built from them contains no
# entry points. They are declared again here so that the documented console
# scripts are installed.
$launcherDir = Join-Path $toolsDir 'launcher'
New-Item -Path $launcherDir -ItemType Directory -Force | Out-Null

$launcherProject = @"
[build-system]
requires = ["setuptools"]
build-backend = "setuptools.build_meta"

[project]
name = "onthespot-entrypoints"
version = "$version"
dependencies = ["onthespot @ git+https://github.com/ots-downloader/onthespot@v$version"]

[project.scripts]
onthespot-cli = "onthespot.cli:main"
onthespot-gui = "onthespot.gui:main"
onthespot-web = "onthespot.web:main"
"@

# The manifest is written without a byte order mark, tomllib rejects one.
$launcherManifest = Join-Path $launcherDir 'pyproject.toml'
[System.IO.File]::WriteAllText($launcherManifest, $launcherProject, (New-Object System.Text.UTF8Encoding($false)))

# windows-curses provides the curses module that the CLI imports, it is not part
# of the Windows standard library.
Invoke-Uv pip install --python $venvPython $launcherDir windows-curses

if (-not (Test-Path $venvPython)) {
  throw "The virtual environment was not created at '$venvDir'."
}

foreach ($script in 'onthespot-cli', 'onthespot-gui', 'onthespot-web') {
  $scriptPath = Join-Path $venvDir "Scripts\$script.exe"
  if (-not (Test-Path $scriptPath)) {
    throw "The $script console script was not created at '$scriptPath'."
  }
  Install-BinFile -Name $script -Path $scriptPath
}

$iconPath     = Join-Path $toolsDir 'onthespot.ico'
$startMenuDir = Join-Path ([Environment]::GetFolderPath('CommonPrograms')) 'OnTheSpot'
New-Item -Path $startMenuDir -ItemType Directory -Force | Out-Null

Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $startMenuDir 'OnTheSpot.lnk') `
  -TargetPath (Join-Path $venvDir 'Scripts\pythonw.exe') `
  -Arguments '-m onthespot.gui' `
  -WorkingDirectory $toolsDir `
  -IconLocation $iconPath `
  -Description 'OnTheSpot music downloader'

Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $startMenuDir 'OnTheSpot Web UI.lnk') `
  -TargetPath $venvPython `
  -Arguments '-m onthespot.web' `
  -WorkingDirectory $toolsDir `
  -IconLocation $iconPath `
  -Description 'OnTheSpot web interface'

# The cache is only needed while installing.
try {
  Invoke-Uv cache clean --quiet
} catch {
  Write-Warning "Failed to clean the uv cache: $_"
}

# Chocolatey automatically shims every executable it finds in the package
# folder. Ignore all of them so that only the console scripts above are shimmed
# and the managed python.exe does not end up on the PATH.
Get-ChildItem -Path $toolsDir -Filter '*.exe' -Recurse | Where-Object {
  -not $_.PSIsContainer
} | ForEach-Object {
  New-Item -Path "$($_.FullName).ignore" -ItemType File -Force | Out-Null
}
