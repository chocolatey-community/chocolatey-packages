$ErrorActionPreference = 'Stop'

$installArgs = $('' +
  '/NORESTART /LANG=english ' +
  '/COMPONENTS="program,ghostscript,comsamples,' +
  'languages,languages\bosnian,languages\catalan,languages\catalan_valencia,' +
  'languages\chinese_simplified,languages\chinese_traditional,' +
  'languages\corsican,languages\croatian,languages\czech,languages\danish,' +
  'languages\dutch,languages\english,languages\estonian,languages\finnish,' +
  'languages\french,languages\galician,languages\german,languages\greek,' +
  'languages\hebrew,languages\hungarian,languages\italian,languages\irish,' +
  'languages\ligurian,languages\latvian,languages\lithuanian,' +
  'languages\norwegian_bokmal,languages\polish,languages\portuguese_br,' +
  'languages\romanian,languages\russian,languages\serbian_cyrillic,' +
  'languages\slovak,languages\slovenian,languages\spanish,' +
  'languages\swedish,languages\turkish,languages\valencian_avl"'
)

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\PDFCreator-3_2_2-Setup.exe"
  softwareName   = 'PDFCreator'
  silentArgs     = $installArgs
  validExitCodes = @(0)
}

# Make sure Print Spooler service is up and running
# this is required for both installing, and running pdfcreator
try {
  $serviceName = 'Spooler'
  $spoolerService = Get-Service -Name $serviceName
  if ($spoolerService -eq $null) { throw "Service $serviceName was not found" }
  Write-Host "Print Spooler service state: $($spoolerService.StartMode) / $($spoolerService.Status)"
  if ($spoolerService.StartMode -ne 'Auto' -or $spoolerService.Status -ne 'Running') {
    Set-Service $serviceName -StartupType Automatic -Status Running
    Write-Host "Print Spooler service new state: Auto / Running"
  }
}
catch {
  Write-Warning "Unexpected error while checking Print Spooler service: $($_.Exception.Message)"
}

# silent install requires AutoHotKey
$ahkFile = Join-Path $toolsPath 'chocolateyInstall.ahk'
$ahkEXE = gci "$env:ChocolateyInstall\lib\autohotkey.portable" -Recurse -filter autohotkey.exe
$ahkProc = Start-Process -FilePath $ahkEXE.FullName -ArgumentList "$ahkFile" -PassThru
Write-Debug "AutoHotKey start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$($ahkProc.Id)"

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem $toolsPath\*.exe | ForEach-Object { New-Item "$_.ignore" -Type file -Force | Out-Null}

if (get-process -id $ahkProc.Id -ErrorAction SilentlyContinue) {stop-process -id $ahkProc.Id}
