import-module au

$releases = "https://nodejs.org/en/download/current/"

if ($MyInvocation.InvocationName -ne '.') { # run the update only if the script is not sourced
  function global:au_BeforeUpdate {
    Remove-Item "$PSScriptRoot\tools\*.msi"

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
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]filePath32\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName32)`""
            "(^[$]filePath64\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName64)`""
        }
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

    #https://nodejs.org/dist/v7.4.0/node-v7.4.0-x86.msi
    $re32  = "node-v(.+)-x86.msi"
    $url32 = $download_page.links | Where-Object href -match $re32 | Select-Object -First 1 -expand href
    $version32 = $matches[1]

    #https://nodejs.org/dist/v7.4.0/node-v7.4.0-x64.msi
    $re64  = "node-v(.+)-x64.msi"
    $url64 = $download_page.links | Where-Object href -match $re64 | Select-Object -First 1 -expand href
    $version64 = $matches[1]

    $filename32 = [IO.Path]::GetFileName($url32)
    $filename64 = [IO.Path]::GetFileName($url64)

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
