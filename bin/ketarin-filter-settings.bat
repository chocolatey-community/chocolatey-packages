@echo off
rem I cannot execute posh scripts. We need a wrapper.

powershell.exe -File "ketarin-filter-settings.ps1" "%*"
