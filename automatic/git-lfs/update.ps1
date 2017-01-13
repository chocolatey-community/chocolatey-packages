import-module au

$releases = "https://github.com/github/git-lfs/releases"

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(<releaseNotes>https:\/\/github.com\/git-lfs\/git-lfs\/releases\/tag\/v)(.*)(<\/releaseNotes>)" = "`${1}$($Latest.Version.ToString())`$3"
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    #git-lfs-windows-1.4.4.exe
    $re  = "git-lfs-windows-.+.exe"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href

    $url32 = "https://github.com" + $url

    $filenameVersionPart = $url -split '-' | select -Last 1
    $version = [IO.Path]::GetFileNameWithoutExtension($filenameVersionPart)

    $filename = $url -split '/' | select -Last 1

    return @{ URL32 = $url32; Version = $version; FileName = $filename }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}
