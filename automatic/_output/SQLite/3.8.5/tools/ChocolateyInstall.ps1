$binDir = join-path $env:ChocolateyInstall "bin"
Install-ChocolateyZipPackage 'SQLite' 'https://www.sqlite.org/2014/sqlite-dll-win32-x86-3080500.zip' $binDir