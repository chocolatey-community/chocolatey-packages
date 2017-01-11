import-module au
import-module "$PSScriptRoot/../../extensions/extensions.psm1"

$releases = 'https://tortoisesvn.net/downloads.html'

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
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    #https://sourceforge.net/projects/tortoisesvn/files/1.9.5/Application/TortoiseSVN-1.9.5.27581-win32-svn-1.9.5.msi/download
    $re32  = "TortoiseSVN-(.*)-win32-svn-(.*).msi"
    $url32 = $download_page.links | Where-Object href -match $re32 | Select-Object -First 1 -expand href

    #https://sourceforge.net/projects/tortoisesvn/files/1.9.5/Application/TortoiseSVN-1.9.5.27581-x64-svn-1.9.5.msi/download
    $re64  = "TortoiseSVN-(.*)-x64-svn-(.*).msi"
    $url64 = $download_page.links | Where-Object href -match $re64 | Select-Object -First 1 -expand href

    $filename32 = $url32 -split '/' | Select-Object -Skip 1 -Last 1
    $filename64 = $url64 -split '/' | Select-Object -Skip 1 -Last 1

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

update -ChecksumFor none