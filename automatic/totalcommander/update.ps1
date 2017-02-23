import-module au
import-module "$PSScriptRoot/../../extensions/chocolatey-core.extension/extensions/chocolatey-core.psm1"

$releases = 'http://www.ghisler.com/amazons3.php'

function GetVersionFromFilename {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Filename,
        [Parameter(Mandatory = $true)]
        [string]$VersionExpression
    )

    $Filename -match $VersionExpression | Out-Null
    $version = $matches[1] -replace "a", ".01"
    $firstPart = $version -split '\.' | Select-Object -First 1
    if ($firstPart.length -gt 2) {
        $version = $version.Replace($firstPart, $firstPart.Insert($firstPart.length - 2, "."))                
    }
    return $version
}

function global:au_BeforeUpdate {
  Remove-Item "$PSScriptRoot\tools\*.exe"
  Remove-Item "$PSScriptRoot\tools\*.zip"

  $client = New-Object System.Net.WebClient
  try 
  {
    $filePath32 = "$PSScriptRoot\tools\$($Latest.FileName32)"
    $client.DownloadFile($Latest.URL32, "$filePath32")

    $filePath64 = "$PSScriptRoot\tools\$($Latest.FileName64)"
    $client.DownloadFile($Latest.URL64, "$filePath64")

    $filePathInstaller = "$PSScriptRoot\tools\$($Latest.FileNameInstaller)"
    $client.DownloadFile($Latest.URLInstaller, "$filePathInstaller")
  }
  finally 
  {
    $client.Dispose()
  }

  $Latest.ChecksumType = "sha256"
  $Latest.Checksum32 = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath32 | ForEach-Object Hash
  $Latest.Checksum64 = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath64 | ForEach-Object Hash
  $Latest.ChecksumInstaller = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePathInstaller | ForEach-Object Hash
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]filePath32\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName32)`""
            "(^[$]filePath64\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName64)`""
            "(^[$]filePathInstaller\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileNameInstaller)`""
        }
        ".\legal\verification.txt" = @{
            "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(Installer.+)\<.*\>" = "`${1}<$($Latest.URLInstaller)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType)"
            "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
            "(?i)(checksumInstaller:\s+).*" = "`${1}$($Latest.ChecksumInstaller)"
        }        
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    #http://tcmd900.s3.amazonaws.com/tcmd900ax32.exe
    $re32  = "tcmd(.*)x32.exe"
    $url32 = $download_page.links | Where-Object href -match $re32 | Select-Object -First 1 -expand href

    #http://tcmd900.s3.amazonaws.com/tcmd900ax64.exe
    $re64  = "tcmd(.*)x64.exe"
    $url64 = $download_page.links | Where-Object href -match $re64 | Select-Object -First 1 -expand href

    $filename32 = [IO.Path]::GetFileName($url32)
    $filename64 = [IO.Path]::GetFileName($url64)

    $version32 = GetVersionFromFilename -Filename $filename32 -VersionExpression $re32
    $version64 = GetVersionFromFilename -Filename $filename64 -VersionExpression $re64

    if ($version32 -ne $version64) {
        throw "Different versions for 32-Bit and 64-Bit detected."
    }

    return @{
        URL32 = $url32 
        URL64 = $url64 
        URLInstaller = "http://ghisler.fileburst.com/addons/installer.zip"
        FileName32 = $filename32
        FileName64 = $filename64
        FileNameInstaller = "installer.zip"
        Version = $version32 
    }
}

update -ChecksumFor none