# This adds a registry key which prevents Google Chrome from getting installed together with Piriform software products

$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

$regDir = 'HKLM:\SOFTWARE\Google\No Chrome Offer Until'
$regDir64 = 'HKLM:\SOFTWARE\Wow6432Node\Google\No Chrome Offer Until'

if ($is64bit) {
    if (-not(Test-Path $regDir64)) {New-Item $regDir64 -ItemType directory -Force}
    New-ItemProperty -Name "Piriform Ltd" -Path $regDir64 -PropertyType DWORD -Value 20991231
} else {
    if (-not(Test-Path $regDir)) {New-Item $regDir -ItemType directory -Force}
    New-ItemProperty -Name "Piriform Ltd" -Path $regDir -PropertyType DWORD -Value 20991231
}