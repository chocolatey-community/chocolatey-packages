param(
  [parameter(Position=0, ValueFromRemainingArguments=$true)]
  [string[]]$packageNames = @(),
  [Parameter(Mandatory=$False)]
  [switch]$upgrade = $false,
  [Parameter(Mandatory=$False)]
  [alias("?","h")][switch]$help = $false,
  [Parameter(Mandatory=$False)]
  [string]$proxy = $null,
  [Parameter(Mandatory=$False)]
  [string]$arch = $null,
  [Parameter(Mandatory=$False)]
  [switch]$notSilent = $false,
  [Parameter(Mandatory=$False)]
  [switch]$noAdmin = $false,
  [Parameter(Mandatory=$False)]
  [switch]$desktop = $false,
  [Parameter(Mandatory=$False)]
  [switch]$startMenu = $false
)

$DebugPreference = "SilentlyContinue"
if ($PSBoundParameters['Debug']) {
  $DebugPreference = "Continue";
}

if ($help -or $packageNames -join '|' -eq '/?') {
  Write-Host "To run please specify `'cyg-get packageName`'."
  Write-Host "You can also specify a list of packages like this: `'cyg-get package1 package2 packageN`'."
  Write-Host "Optional params: -upgrade"
  Write-Host "Optional params: -proxy host:port"
  Write-Host "Optional params: -arch x86_64 or x86"
  Write-Host "Optional params: -noadmin"
  Write-Host "Optional params: -desktop"
  Write-Host "Optional params: -startmenu"
  Write-Host "Optional params: -debug"
} elseif ($packageNames -eq $null -or $packageNames -eq '' -or $packageNames.Count -eq 0 ) {
  Write-Warning 'Please specify a package or list of packages. Run -help or /? for more information.'
} else {
  $local_key =  'HKLM:\SOFTWARE\Cygwin\setup'
  $local_key6432 =  'HKLM:\SOFTWARE\Wow6432Node\Cygwin\setup'

  try {

    $cygRoot = @($local_key, $local_key6432) | ?{Test-Path $_} | Get-ItemProperty | Select-Object -ExpandProperty rootdir
    if ($cygRoot -eq $null) {
      throw "Cygwin install not found"
    }

    $cygwinsetup = "$cygRoot\cygwinsetup.exe"
    $cygLocalPackagesDir = join-path $cygRoot packages
    $cygInstallPackageList = $packageNames -join ','

    $cygArgs = "--root $cygRoot --local-package-dir $cygLocalPackagesDir --download"

    $windowStyle = 'Minimized'
    if (!$notSilent) {
      $cygArgs +=" --quiet-mode"
    } else {
      $cygArgs +=" --package-manager"
      $windowStyle = 'Normal'
    }       

    if ($upgrade) {
      $cygArgs +=" --upgrade-also"
    }

    if ($proxy -ne $null -and $proxy -ne '') {
      Write-Debug "Adding optional proxy value '$proxy'"
      $cygArgs +=" --proxy '$proxy'"
    }

    if ($noAdmin) {
      Write-Debug "Setting --no-admin"
      $cygArgs +=" --no-admin"
    }
    #else {
      #Write-Debug "Ensure --wait for admin mode (if enforced)"
      #$cygArgs +=" --wait"
    #}

    if (!$desktop) {
      Write-Debug "Ensuring --no-desktop"
      $cygArgs +=" --no-desktop"
    }

    if (!$startMenu) {
      Write-Debug "Ensuring --no-startmenu"
      $cygArgs +=" --no-startmenu"
    }

    if ($arch -ne $null -and $arch -ne '') {
      Write-Debug "Adding optional architecture value '$arch'"
      $cygArgs +=" --arch $arch"
    }

    $cygArgs +=" --packages $cygInstallPackageList"

    Write-Host "Attempting to install cygwin packages: $cygInstallPackageList"
    Write-Debug "$cygwinsetup $cygArgs"
    
    Start-Process -FilePath $cygwinsetup -ArgumentList $cygArgs -Wait -WindowStyle $windowStyle
  }
  catch {
    Write-Error "Please ensure you have Cygwin installed. To install please `ncall 'choco install cygwin' (optionally add -y to autoconfirm). `nERROR: $($_.Exception.Message)"
  }
}
