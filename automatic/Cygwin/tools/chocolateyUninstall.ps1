Remove-Item 'HKLM:\SOFTWARE\Cygwin' -Recurse -ErrorAction SilentlyContinue
Uninstall-BinFile -Name Cygwin
