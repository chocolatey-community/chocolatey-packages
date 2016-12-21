import-module au

$releases = "https://git-scm.com/download/win"

function global:au_BeforeUpdate {
  Remove-Item "$PSScriptRoot\tools\*.exe"

  $client = New-Object System.Net.WebClient
  try 
  {
    $filePath32 = "$PSScriptRoot\tools\$($Latest.FileName32)"
    $client.DownloadFile($Latest.URL32, "$filePath32")

    $filePath64 = "$PSScriptRoot\tools\$($Latest.FileName64)"
    $client.DownloadFile($Latest.URL64, "$filePath64")
  }
  finally 
  {
    $client.Dispose()
  }

  $Latest.ChecksumType = "sha256"
  $Latest.Checksum32 = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath32 | ForEach-Object Hash
  $Latest.Checksum64 = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath64 | ForEach-Object Hash
}

function global:au_SearchReplace {
    @{
        ".\legal\verification.txt" = @{
            "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType)"
            "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
        }        
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    #https://github.com/git-for-windows/git/releases/download/v2.11.0.windows.1/PortableGit-2.11.0-32-bit.7z.exe
    $re32  = "PortableGit-.+-32-bit.7z.exe"
    $url32 = $download_page.links | Where-Object href -match $re32 | Select-Object -First 1 -expand href

    #https://github.com/git-for-windows/git/releases/download/v2.11.0.windows.1/PortableGit-2.11.0-64-bit.7z.exe
    $re64  = "PortableGit-.+-64-bit.7z.exe"
    $url64 = $download_page.links | Where-Object href -match $re64 | Select-Object -First 1 -expand href

    $filename32 = [IO.Path]::GetFileName($url32)
    $filename64 = [IO.Path]::GetFileName($url64)

    $version32 = $filename32 -split '-' | Select-Object -Skip 1 -First 1
    $version64 = $filename64 -split '-' | Select-Object -Skip 1 -First 1

    if ($version32 -ne $version64) {
        throw "Different versions for 32-Bit and 64-Bit detected."
    }

    return @{
        URL32 = $url32 
        URL64 = $url64 
        FileName32 = $filename32
        FileName64 = $filename64
        Version = $version32 
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}