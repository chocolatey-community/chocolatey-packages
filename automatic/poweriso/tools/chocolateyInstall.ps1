$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.universedlgift.com/0BChGlnugMml_STNvEmMNf2OSkqJrdWURcVq1Rp9VS7rxJj_aeC1dFnrJD5T4dZ3jkQ61fWRtqNHgM2u54nv7RSzB1iOge80YwC6XDAq0NE5vOAWvBNCmb7tUxe8Kq9ZzYq91putd67Z0urYmGiaBUxS8Iaa7Q==-G0oAAGRsXWvX4IeysG7DBhw4lUlAtuOwMXau4HEXNRYU6s7hF+KO241fppgTQiFTQlUCUiK4Qam+UmB6c_MFn3OCeT_716E='
  url64bit               = 'http://www.worldnowclear.com/CZYQf2Y1o1dgAvypmFGfO6m3Vmot7burPYZceI_lz19QjUB7AG8XWGDSSSLSYHsYsY6mCkmHK9_ilKr7btrr2Ku6jkOFNnwd3g6zEl3mQRbJN7AAxVXNQ6Kyv86XVN23T6DXzD5gg9lsjgSmdqa8tG4ozaasdg==-G1EAAGTcXGs0k8TI8vu6O2zAgVOZBGQD4LAxdq7gcRc1FhTqzuEX4o7biytTqARslx9zQihkSqhKQK0oVUTpsQLTzs3nP3OCeT_711A='
  checksum               = '3a18891f5cc5f2fcf46fc1b4eda3c99ebaee4c06d4b8e6409507096d45985c76'
  checksum64             = 'b8c6a05c6322d1884f0c5347dfde9d1f95ab58218a20b9c884d3a5e78b315d8d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
