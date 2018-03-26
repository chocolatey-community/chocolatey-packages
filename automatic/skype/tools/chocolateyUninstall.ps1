$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

if ($is64bit) {
    $programUninstallEntryName = "Skype"
    $uninstallString = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select DisplayName, UninstallString | Where-Object {$_.DisplayName -like "$programUninstallEntryName*"}).UninstallString
} else {
    $programUninstallEntryName = "Skype"
    $uninstallString = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select DisplayName, UninstallString | Where-Object {$_.DisplayName -like "$programUninstallEntryName*"}).UninstallString
} # get the uninstall string of the installed Skype version from the registry

$uninstallString = "$uninstallString" -replace '[{]', '`{' # adding escape character to the braces
$uninstallString = "$uninstallString" -replace '[}]', '`} /passive /norestart' # to work properly with the Invoke-Expression command, add silent arguments

if ($uninstallString -ne "") {
    Invoke-Expression "$uninstallString" # start uninstaller
}
