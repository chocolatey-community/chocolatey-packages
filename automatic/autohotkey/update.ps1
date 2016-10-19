import-module au

$releases = 'https://autohotkey.com/download/1.1'

function global:au_SearchReplace {
  @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"$($Latest.Version)`""
        }
    }
 }

function global:au_GetLatest {
    $version = Invoke-WebRequest -Uri "$releases\version.txt" -UseBasicParsing | % Content
    $url     = "$releases/AutoHotkey_${version}"
    @{ URL_i = "${url}_setup.exe"; URL_p= "${url}.zip"; Version = $version }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none
}
