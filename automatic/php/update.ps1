import-module au

$releases = 'http://windows.php.net/download'

function global:au_BeforeUpdate {
  rm -Recurse -Force "$PSScriptRoot\tools\*.zip"
  # threadsafe
  $Latest.FileNameTS32 = $Latest.URLTS32 -split '/' | select -Last 1
  iwr $Latest.URLTS32 -OutFile tools\$($Latest.FileNameTS32)
  $Latest.ChecksumTS32 = Get-FileHash tools\$($Latest.FileNameTS32) | % Hash

  $Latest.FileNameTS64 = $Latest.URLTS64 -split '/' | select -Last 1
  iwr $Latest.URLTS64 -OutFile tools\$($Latest.FileNameTS64)
  $Latest.ChecksumTS64 = Get-FileHash tools\$($Latest.FileNameTS64) | % Hash

  # non-threadsafe
  $Latest.FileNameNTS32 = $Latest.URLNTS32 -split '/' | select -Last 1
  iwr $Latest.URLNTS32 -OutFile tools\$($Latest.FileNameNTS32)
  $Latest.ChecksumNTS32 = Get-FileHash tools\$($Latest.FileNameNTS32) | % Hash

  $Latest.FileNameNTS64 = $Latest.URLNTS64 -split '/' | select -Last 1
  iwr $Latest.URLNTS64 -OutFile tools\$($Latest.FileNameNTS64)
  $Latest.ChecksumNTS64 = Get-FileHash tools\$($Latest.FileNameNTS64) | % Hash
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>"                     = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software \(threadsafe\).*)\<.*\>"      = "`${1}<$($Latest.URLTS32)>"
      "(?i)(\s*64\-Bit Software \(threadsafe\).*)\<.*\>"      = "`${1}<$($Latest.URLTS64)>"
      "(?i)(\s*32\-Bit Software \(non\-threadsafe\).*)\<.*\>" = "`${1}<$($Latest.URLNTS32)>"
      "(?i)(\s*64\-Bit Software \(non\-threadsafe\).*)\<.*\>" = "`${1}<$($Latest.URLNTS64)>"
      "(?i)(^\s*checksum\s*type\:).*"                         = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)? \(threadsafe\)\:).*"            = "`${1} $($Latest.ChecksumTS32)"
      "(?i)(^\s*checksum64 \(threadsafe\)\:).*"               = "`${1} $($Latest.ChecksumTS64)"
      "(?i)(^\s*checksum(32)? \(non\-threadsafe\)\:).*"       = "`${1} $($Latest.ChecksumNTS32)"
      "(?i)(^\s*checksum64 \(non\-threadsafe\)\:).*"          = "`${1} $($Latest.ChecksumNTS64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*filets32\s*=\s*`"[$]toolsPath\\).*"  = "`${1}$($Latest.FileNameTS32)`""
      "(?i)(^\s*filets64\s*=\s*`"[$]toolsPath\\).*"  = "`${1}$($Latest.FileNameTS64)`""
      "(?i)(^\s*filents32\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileNameNTS32)`""
      "(?i)(^\s*filents64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileNameNTS64)`""
    }
    "$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*?(\</releaseNotes\>)"                   = "`${1}$($Latest.ReleaseNotes)`$2"
      "(\<dependency .+?`")vcredist[^`"]+`"( version=`"[^`"]+`")?" = "`$1$($Latest.Dependency.Id)`" version=`"$($Latest.Dependency.Version)`""
    }
  }
}

function Get-Dependency() {
  param($url)

  $dep = $url -split '\-' | select -last 1 -skip 1

  $result = @{
    'vc15' = @{ Id = 'vcredist140'; Version = '14.11.25325.0' }
    'vc14' = @{ Id = 'vcredist140'; Version = '14.0.24215.1' }
    'vc11' = @{ Id = 'vcredist2012'; Version = '11.0.61031' }
  }.GetEnumerator() | ? Key -eq $dep | select -first 1 -expand Value

  if (!$result) {
    throw "VC Redistributable version was not found. Please check the script."
  }
  return $result
}

function CreateStream {
  param([uri]$url32Bit, [uri]$url64bit, [version]$version)

  $Result = @{
    Version      = $version
    URLNTS32     = 'http://windows.php.net' + $url32bit
    URLNTS64     = 'http://windows.php.net' + $url64bit
    URLTS32      = 'http://windows.php.net' + ($url32bit | % { $_ -replace '\-nts', '' })
    URLTS64      = 'http://windows.php.net' + ($url64bit | % { $_ -replace '\-nts', '' })
    ReleaseNotes = "https://secure.php.net/ChangeLog-$($version.Major).php#${version}"
    Dependency   = Get-Dependency $url32Bit
  }

  if ($Result.URLNTS32 -eq $Result.TS32) {
    throw "The threadsafe and non-threadsafe 32bit url is equal... This is not expected"
  }

  if ($Result.URLNTS64 -eq $Result.TS64) {
    throw "The threadsafe and non-threadsafe 64bit url is equal... This is not expected"
  }

  return $Result
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $url32Bits = $download_page.links | ? href -match 'nts.*x86\.zip$' | ? href -notmatch 'debug|devel' | select -expand href
  $url64Bits = $download_page.links | ? href -match 'nts.*x64\.zip$' | ? href -notmatch 'debug|devel' | select -expand href

  $streams = @{ }

  $url32Bits | sort | % {
    $version = $_ -split '-' | select -first 1 -Skip 1
    $url64Bit = $url64Bits | ? { $_ -split '-' | select -first 1 -skip 1 | ? { $_ -eq $version } }

    $streams.Add((Get-Version $version).ToString(2), (CreateStream $_ $url64Bit $version))

  } | Out-Null

  return @{ Streams = $streams }
}

update -ChecksumFor none
