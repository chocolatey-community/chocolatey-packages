$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.universedlgift.com/eqAj56bakHiihU_HTwmF2ub+FCGrQwHT1aEOLWaV_O3BJrgRtrohvUcs4Bi4jTBLxWcUNFXIatnyBDB5hoQUd+0J6quvjqzOr5plkNAjb7AnudlhNPLfVVgBj8J5jLg1n7dj5KCbuM3cxjFOPlgQkrNx3KdbLw==-G0oAAGRsXWvX4IeysG7DBhw4lUlAtuOwMXau4HEXNRYU6s7hF+KO241fppgTQiFTQlUCUiK4Qam+UmB6c_MFn3OCeT_716E='
  url64bit               = 'http://www.worldnowclear.com/Nw0nNyL2FxY5C0W0Rg1JxPsma8_eo0SrHI8cKdnF7P4ErphBpGc+DzJUNpSw9VvHlmBh5cFT0uNVH+Ic2dFgOlbfhI1r0FyxbbHg9gCBdaog9PdMbSaSMB9mGQg5jsLgAshpsTFq8ViOggryOeYGVeebWstHqQ==-G1EAAGTcXGs0k8TI8vu6O2zAgVOZBGQD4LAxdq7gcRc1FhTqzuEX4o7biytTqARslx9zQihkSqhKQK0oVUTpsQLTzs3nP3OCeT_711A='
  checksum               = '3a18891f5cc5f2fcf46fc1b4eda3c99ebaee4c06d4b8e6409507096d45985c76'
  checksum64             = 'b8c6a05c6322d1884f0c5347dfde9d1f95ab58218a20b9c884d3a5e78b315d8d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
