Update-SessionEnvironment
$allowed_python_versions = @('3.9', '3.8', '3.7', '3.6', '3.5') # sync with nuspec
$version = '1.1.2'

$proxy = Get-EffectiveProxy
if ($proxy) {
  Write-Host "Setting CLI proxy: $proxy"
  $env:http_proxy = $env:https_proxy = $proxy
}

function FindPython {
  param(
    $allowed_python_versions
  )
  # see https://www.python.org/dev/peps/pep-0514/#structure
  # we are querying machine regsitry only because chocolatey
  # installs python in admin mode only.
  $avaiable_installation = Get-ChildItem -Path Registry::HKEY_LOCAL_MACHINE\Software\Python\PythonCore | Select-Object Name
  foreach ($install in $avaiable_installation) {
    $name_install = $install.Name
    $install_version = ($name_install -split '\\')[-1]
    if ($allowed_python_versions.Contains($install_version)) {
      Write-Host "Found Python Version from Registry $install_version" -ForegroundColor Yellow
      $python_executable = Get-ItemProperty -Path "Registry::$name_install\InstallPath" | Select-Object ExecutablePath
      Write-Host "Found Install Path from Registry $($python_executable.ExecutablePath)" -ForegroundColor Yellow
      return $python_executable.ExecutablePath
    }
  }
}

$python = FindPython $allowed_python_versions
Write-Host "Found python at '$python'. Using it."
& "$python" -m ensurepip # make sure pip exists
& "$python" -m pip install mkdocs==$version
