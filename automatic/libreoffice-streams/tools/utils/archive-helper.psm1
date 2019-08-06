<#
 .Synopsis
  Checks if the URL provided is available or not.

 .Description
  Checks if the URL provided is available or not. Return 'True' if URL is available
  and 'False' if not.

 .Parameter url
  Provide the URL as String.

 .Example
   # Check if URL is available.
   Get-URLStatus "https://www.google.de"
#>

function Get-URLStatus{
    [CmdletBinding()]
    Param(
    [Parameter(ValueFromPipeline)]
    [String]$url
    )
    
    try {
        [net.httpWebRequest] $req = [net.webRequest]::create($url)
        $req.Method = "HEAD"
        [net.httpWebResponse] $res = $req.getResponse()

        if ($res.StatusCode -eq "200") {
            # version is not archived yet
            Return $true
            continue
        }
        } catch {
            # version got archived
            Return $false
            continue
        }
}

Export-ModuleMember -Function Get-URLStatus

<#
 .Synopsis
  Returns the SHA256 matching URL of the LibreOffice software.

 .Description
  This function returns the archive URLs of the LibreOffice software based
  on the provided Version (like 6.0.7) and SHA256 values.

 .Parameter softwareVersion
  The software version, like 6.0.7.

 .Parameter softwareHash32
  The SHA256 hash of the 32bit installer file.

 .Parameter softwareHash64
  The SHA256 hash of the 64bit installer file.

 .Example
  Get-ArchiveURL -softwareVersion "6.0.7" -softwareHash32 "abcd" -softwareHash64 "def"
#>

function Get-ArchiveURL{
    [CmdletBinding()]
    Param(
    [Parameter(ValueFromPipeline)]
    [String]$softwareVersion,
    [String]$softwareHash64,
    [String]$softwareHash32
    )
    
    $archiveURL = Invoke-WebRequest http://downloadarchive.documentfoundation.org/libreoffice/old/ -UseBasicParsing  
    $versions = $archiveURL.Links |?{$_.href -match $softwareVersion} 

    ForEach ($version in $versions.href){
        $version = $version.Replace("/","")
        # Download mirrorlist, search for the sha256 string

        $mirrorListURL64 = "http://downloadarchive.documentfoundation.org/libreoffice/old/${version}/win/x86_64/LibreOffice_${version}_Win_x64.msi.mirrorlist"
        $mirrorListURL32 = "http://downloadarchive.documentfoundation.org/libreoffice/old/${version}/win/x86/LibreOffice_${version}_Win_x86.msi.mirrorlist"
        $tmpFile64 = $env:TEMP+"\libreoffice_64_${version}_mirrorlist.txt"
        $tmpFile32 = $env:TEMP+"\libreoffice_32_${version}_mirrorlist.txt"

        (New-Object System.Net.WebClient).DownloadFile($mirrorListURL64, $tmpFile64)
        (New-Object System.Net.WebClient).DownloadFile($mirrorListURL32, $tmpFile32)

        if (((Get-Content $tmpFile64 | Where { $_.Contains($softwareHash64) }) -match $softwareHash64) -and ((Get-Content $tmpFile32 | Where { $_.Contains($softwareHash32) }) -match $softwareHash32)) {
            # version number matches, set download path for 64 bit           
			$returnURLs = @()
			$returnURLs += ( $downloadURL32 = $mirrorListURL32.Replace(".mirrorlist","") )
			$returnURLs += ( $downloadURL64 = $mirrorListURL64.Replace(".mirrorlist","") )
			
            Return $returnURLs

            Remove-Item -Path $env:TEMP\libreoffice*.txt
            continue
        } else { 
            Write-Debug "$version does not match bit hash"
            Remove-Item -Path $env:TEMP\libreoffice*.txt
            continue
        }
    }
}

Export-ModuleMember -Function Get-ArchiveURL