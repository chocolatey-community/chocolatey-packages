$toolsPath   = (Split-Path $MyInvocation.MyCommand.Definition)
$bits = Get-ProcessorBits
if ($bits -eq 64)
{
regedit /s $toolsPath\install_x64.reg
}
else
{
regedit /s $toolsPath\install_x86.reg
}