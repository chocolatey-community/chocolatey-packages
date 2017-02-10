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
  $reInstaller  = "putty-(.+)-installer.msi"
  $url32Installer = $download_page.links | Where-Object href -match $reInstaller | Select-Object -First 1 -expand href
  $version = $matches[1] 
  $filename32Installer = [IO.Path]::GetFileName($url32Installer)

  #https://the.earth.li/~sgtatham/putty/latest/x86/putty.zip
  $rePortable  = "putty.zip"
  $url32Portable = $download_page.links | Where-Object href -match $rePortable | Select-Object -First 1 -expand href
  $filename32Portable = [IO.Path]::GetFileName($url32Portable)


  return @{
    URL32Installer = $url32Installer
    FileName32Installer = $filename32Installer
    URL32Portable = $url32Portable
    FileName32Portable = $filename32Portable
    Version = $version
  }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
  update -ChecksumFor none
}