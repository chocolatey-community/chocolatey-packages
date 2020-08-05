# Check if Windows Sandbox is enabled

if (-Not (Test-Path "$env:windir\System32\WindowsSandbox.exe")) {
  Write-Error -Category NotInstalled -Message @'
Windows Sandbox does not seem to be available. Check the following URL for prerequisites and further details:
https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-sandbox/windows-sandbox-overview

You can run the following command in an elevated PowerShell for enabling Windows Sandbox:
Enable-WindowsOptionalFeature -Online -FeatureName 'Containers-DisposableClientVM'
'@ -ErrorAction Stop
}

# Closing Windows Sandbox

$sandbox = Get-Process WindowsSandboxClient -ErrorAction SilentlyContinue
if ($sandbox) {
  Write-Host '--> Closing Windows Sandbox'
  $sandbox | Stop-Process
  Start-Sleep -Seconds 5
}
Remove-Variable sandbox

# Initialize Temp Folder

$repositoryFolder = Get-Item $(git rev-parse --show-toplevel)

$tempFolder = Join-Path -Path $PSScriptRoot -ChildPath 'Test-Sandbox_Temp'

New-Item $tempFolder -ItemType Directory -ea 0 | Out-Null

Get-ChildItem $tempFolder -Recurse | Remove-Item -Force

# Create Bootstrap script

$bootstrapPs1Content = @"
clear
Write-Host '--> Installing Chocolatey'
Write-Host
iwr -useb 'https://chocolatey.org/install.ps1' | iex
Write-Host
Write-Host '--> Enabling automatic confirmation for Chocolatey'
Write-Host
choco feature enable -n=allowGlobalConfirmation
Write-Host
"@
if (-Not [string]::IsNullOrWhiteSpace($args)) {
  $bootstrapPs1Content += @"

Write-Host '--> Running the following command:'
Write-Host '    $ $args'
Write-Host
$args
Write-Host
"@
}

$bootstrapPs1FileName = 'Bootstrap.ps1'
$bootstrapPs1Content | Out-File (Join-Path -Path $tempFolder -ChildPath $bootstrapPs1FileName)

# Create Wsb file

$repositoryFolderInSandbox = Join-Path -Path 'C:\Users\WDAGUtilityAccount\Desktop' -ChildPath (Split-Path -Path $repositoryFolder -Leaf)
$bootstrapPs1InSandbox = Join-Path -Path "scripts/Test-Sandbox_Temp" -ChildPath $bootstrapPs1FileName

$sandboxTestWsbContent = @"
<Configuration>
  <MappedFolders>
    <MappedFolder>
      <HostFolder>$repositoryFolder</HostFolder>
    </MappedFolder>
  </MappedFolders>
  <LogonCommand>
  <Command>PowerShell Start-Process PowerShell -WindowStyle Maximized -WorkingDirectory '$repositoryFolderInSandbox' -ArgumentList '-ExecutionPolicy Bypass -NoExit -File $bootstrapPs1InSandbox'</Command>
  </LogonCommand>
</Configuration>
"@

$sandboxTestWsbFileName = 'SandboxTest.wsb'
$sandboxTestWsbFile = Join-Path -Path $tempFolder -ChildPath $sandboxTestWsbFileName
$sandboxTestWsbContent | Out-File $sandboxTestWsbFile

Write-Host '--> Starting Windows Sandbox, and:'
Write-Host '    - Mounting the following directory:'
Write-Host "      $repositoryFolder"
Write-Host '    - Installing Chocolatey'
if (-Not [string]::IsNullOrWhiteSpace($args)) {
  Write-Host '    - Running the following command:'
  Write-Host "      $ $args"
}

WindowsSandbox $SandboxTestWsbFile
