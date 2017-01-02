import-module au

$releases = "https://github.com/github/git-lfs/releases"

function global:au_BeforeUpdate {
  Remove-Item "$PSScriptRoot\tools\*.exe"

  $client = New-Object System.Net.WebClient
  try 
  {
    $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"

    $client.DownloadFile($Latest.URL32, "$filePath")
  }
  finally 
  {
    $client.Dispose()
  }

  $Latest.ChecksumType = "sha256"
  $Latest.Checksum = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath | % Hash
}

function global:au_SearchReplace {
    @{
        ".\git-lfs.install.nuspec" = @{
            "(<releaseNotes>https:\/\/github.com\/git-lfs\/git-lfs\/releases\/tag\/v)(.*)(<\/releaseNotes>)" = "`${1}$($Latest.Version.ToString())`$3"
        }
        "tools\chocolateyInstall.ps1" = @{
            "(?i)(`"`[$]toolsDir\\).*`"" = "`${1}$($Latest.FileName)`""
        }
        ".\tools\verification.txt" = @{
            "(?i)(1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType)"
            "(?i)(checksum:\s+).*" = "`${1}$($Latest.Checksum)"
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