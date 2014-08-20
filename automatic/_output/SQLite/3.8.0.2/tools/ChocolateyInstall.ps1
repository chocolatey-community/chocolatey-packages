$binDir = join-path $env:ChocolateyInstall "bin"
Install-ChocolateyZipPackage 'SQLite' 'https://www.sqlite.org/2013/sqlite-dll-win32-x86-3080002.zip' $binDir