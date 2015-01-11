$packageName = 'mxnitro'
$installerType = 'EXE'
$url = 'http://dl.maxthon.com/mxnitro_alpha/mxnitro1.0.0.700-alpha-EB97A06C4D11BF590D406BD9CA370C66.exe'
$silentArgs = '/S'
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes