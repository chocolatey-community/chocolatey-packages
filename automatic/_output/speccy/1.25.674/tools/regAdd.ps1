# This adds a registry key which prevents Google Chrome from getting installed together with Speccy

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

$regDirChrome = 'HKLM:\SOFTWARE\Google\No Chrome Offer Until'
$regDir64Chrome = 'HKLM:\SOFTWARE\Wow6432Node\Google\No Chrome Offer Until'
$regDirToolbar = 'HKLM:\SOFTWARE\Google\No Toolbar Offer Until'
$regDir64Toolbar = 'HKLM:\SOFTWARE\Wow6432Node\Google\No Toolbar Offer Until'

if ($is64bit) {
    if (-not(Test-Path $regDir64Chrome)) {New-Item $regDir64Chrome -ItemType directory -Force}
    New-ItemProperty -Name "Piriform Ltd" -Path $regDir64Chrome -PropertyType DWORD -Value 20991231 -Force
    if (-not(Test-Path $regDir64Toolbar)) {New-Item $regDir64Toolbar -ItemType directory -Force}
    New-ItemProperty -Name "Piriform Ltd" -Path $regDir64Toolbar -PropertyType DWORD -Value 20991231 -Force
} else {
    if (-not(Test-Path $regDirChrome)) {New-Item $regDirChrome -ItemType directory -Force}
    New-ItemProperty -Name "Piriform Ltd" -Path $regDirChrome -PropertyType DWORD -Value 20991231 -Force
    if (-not(Test-Path $regDirToolbar)) {New-Item $regDirToolbar -ItemType directory -Force}
    New-ItemProperty -Name "Piriform Ltd" -Path $regDirToolbar -PropertyType DWORD -Value 20991231 -Force
}