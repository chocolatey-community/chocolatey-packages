$validExitCodes = @(0,1223)
Install-ChocolateyPackage 'avidemux' 'exe' '/S' 'http://heanet.dl.sourceforge.net/project/avidemux/avidemux/2.6.4/avidemux_2.6.4_win32.exe' -validExitCodes $validExitCodes