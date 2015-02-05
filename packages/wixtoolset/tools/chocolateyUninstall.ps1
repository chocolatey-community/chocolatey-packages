$packageName = 'wixtoolset'

$msiArgs = $('/x{7B9D7DD6-3490-417D-843C-7982B1DB1859} /q REBOOT=ReallySuppress')
Start-ChocolateyProcessAsAdmin $msiArgs 'msiexec'