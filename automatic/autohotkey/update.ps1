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
    $url     = "$releases/AutoHotkey${v}" + ($version -replace '\.')

    @{ URL_i = "${url}_Install.exe"; URL_p32= "$url.zip"; URL_p64= "${url}_x64.zip"; Version = $version }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none -NoCheckUrl
}
