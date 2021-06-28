$ErrorActionPreference = 'Stop'

$osBitness = Get-OSArchitectureWidth
$path      = "$progDir\mingw$osBitness\bin\octave.bat"

# Unlink batch
Uninstall-BinFile -Name 'octave'     -Path $path
Uninstall-BinFile -Name 'octave-cli' -Path $path
