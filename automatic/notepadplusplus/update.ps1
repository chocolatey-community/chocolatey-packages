import-module au

$releases = 'https://github.com/notepad-plus-plus/notepad-plus-plus/releases'

function global:au_SearchReplace {
  @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"$($Latest.Version)`""
        }
    }
 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest $releases
    $version = $download_page.AllElements | ? class -eq 'release-title'

    @{ URL_i = "${url}_Install.exe"; URL_p32= "$url.zip"; URL_p64= "${url}_x64.zip"; Version = $version }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none -NoCheckUrl
}
