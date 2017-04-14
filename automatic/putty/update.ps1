import-module au

$releases = "http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html"

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).portable`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  #https://the.earth.li/~sgtatham/putty/latest/x86/putty-0.67-installer.msi
  $url32Installer = $download_page.links | ? href -match '\.msi$' | ? href -notmatch '64bit' | select -First 1 -expand href
  $url64Installer = $download_page.links | ? href -match '64bit.*\.msi$' | select -First 1 -expand href

  $version = $url32Installer -split '\-' | select -last 1 -skip 1

  #https://the.earth.li/~sgtatham/putty/latest/x86/putty.zip
  $rePortable  = "putty.zip"
  $portables = $download_page.links | ? href -match $rePortable | select -First 2 -expand href
  $url32Portable = $download_page.links | ? href -match "w32.*$rePortable" | select -First 1 -expand href
  $url64Portable = $download_page.links | ? href -match "w64.*$rePortable" | select -First 1 -expand href

  if (!$url32Installer -or !$url64Installer -or !$url32Portable -or !$url64Portable) {
    throw "Either 32bit or 64bit installer/portable was not found. Please check if naming have changed."
  }

  return @{
    URL32Installer = $url32Installer
    URL64Installer = $url64Installer
    URL32Portable = $url32Portable
    URL64Portable = $url64Portable
    Version = $version
  }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  update -ChecksumFor none
}
