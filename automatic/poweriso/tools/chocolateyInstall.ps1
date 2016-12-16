$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.universedlgift.com/+zQNrYiOhVsbCLkAQaGhwajksYhG4YiAEkAzPwFdxjX3GdYt1q+ELdClaOYJZM2P++i8R4lMT58xrYWTiGAcvo5hE4+eS0RvJl6oZvZIxYG3k2TtUa2AfTGA6VGE+VFlADYPjqBFc07Xzr3slzv6z_E4PBZ_dg==-G0oAAGRsXWvX4IeysG7DBhw4lUlAtuOwMXau4HEXNRYU6s7hF+KO241fppgTQiFTQlUCUiK4Qam+UmB6c_MFn3OCeT_716E='
  url64bit               = 'http://www.worldnowclear.com/TOBh6YywsrjIB7xW49H7NrO9iWoMIganz3DS6eYUNuDgJNzXQIbzBkEnWzqupb7w4Pxn07qE0aUNCQcYBqWf5PVReTc3GzZgUDljBEOnjdxTIAuqMKguq6_HdSFYpqjcS_5Vc8l4ZMw4qFsh70HKAZp9q1oGqQ==-G1EAAGTcXGs0k8TI8vu6O2zAgVOZBGQD4LAxdq7gcRc1FhTqzuEX4o7biytTqARslx9zQihkSqhKQK0oVUTpsQLTzs3nP3OCeT_711A='
  checksum               = '3a18891f5cc5f2fcf46fc1b4eda3c99ebaee4c06d4b8e6409507096d45985c76'
  checksum64             = 'b8c6a05c6322d1884f0c5347dfde9d1f95ab58218a20b9c884d3a5e78b315d8d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
