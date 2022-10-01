import-module au

Add-Type -Assembly System.IO.Compression

$release_files_url = 'https://www.python.org/api/v2/downloads/release_file/'

function global:au_SearchReplace {
    @{
        ".\legal\LICENSE.txt" = @{
            "(?s)^.*$" = $Latest.License
        }
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(^\s*location on\:?\s*)\<.*\>"      = "`${1}<$release_files_url>"
          "(?i)(\s*32\-Bit Software.*)\<.*\>"      = "`${1}<$($Latest.URL32)>"
          "(?i)(\s*64\-Bit Software.*)\<.*\>"      = "`${1}<$($Latest.URL64)>"
          "(?i)(^\s*checksum\s*type\:).*"          = "`${1} $($Latest.ChecksumType32)"
          "(?i)(^\s*checksum(32)?\:).*"            = "`${1} $($Latest.Checksum32)"
          "(?i)(^\s*checksum64\:).*"               = "`${1} $($Latest.Checksum64)"
          "(?i)(\s*Documentation archive.*)\<.*\>" = "`${1}<$($Latest.ZipUrl)>"
        }
        ".\tools\chocolateyInstall.ps1" = @{
          "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*"   = "`${1}$($Latest.FileName32)`""
          "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix

    # download Python documentation archive
    $webrequest = [System.Net.HttpWebRequest]::Create($Latest.ZipUrl)
    $response_stream = $webrequest.GetResponse().GetResponseStream()
    $zip = [IO.Compression.ZipArchive]::new($response_stream)

    # license text for legal/LICENSE.txt
    $license_entry = $zip.GetEntry("$($Latest.ZipName)/license.txt")
    $Latest.License = [System.IO.StreamReader]::new($license_entry.Open()).ReadToEnd()

    # copyright information for nuspec
    $copyright_entry = $zip.GetEntry("$($Latest.ZipName)/copyright.txt")
    $reader = [System.IO.StreamReader]::new($copyright_entry.Open())
    (1..5) | % {$reader.ReadLine()}  # skip header
    $copyright = ''
    $reading_copyright = $false
    while (($line = $reader.ReadLine()) -ne $null) {
        if (!$line) {
            $copyright += "`n"
            $reading_copyright = $false
            continue
        }
        if ($line.StartsWith('Copyright')) {
            if ($reading_copyright) {
                $copyright += "`n"
            }
            $copyright += $line
            $reading_copyright = $true
        } elseif ($reading_copyright) {
            $copyright += " $line"
        } else {
            break
        }
    }
    $Latest.Copyright = $copyright.Trim()
}

function global:au_AfterUpdate($Package) {
    $cdata = $Package.NuspecXml.CreateCDataSection($Latest.Copyright)
    $xml_Copyright = $Package.NuspecXml.GetElementsByTagName('copyright')[0]
    $xml_Copyright.RemoveAll()
    $xml_Copyright.AppendChild($cdata) | Out-Null
    $Package.SaveNuspec()
}

function global:au_GetLatest {
    $release_files = Invoke-RestMethod $release_files_url
    $version_re = '3\.10\.(?<micro>\d+)(?:(?<releaselevel>a|b|rc)(?<serial>\d+))?'
    $re = '^python-(?<version>' + $version_re + ')(?<amd64>-amd64)?\.exe$'
    $versions = @{}
    foreach ($file in $release_files) {
        $file_name = $file.url.Split('/')[-1]
        if ($file_name -match $re) {
            $version = $matches['version']
            $amd64 = $matches['amd64']
            if (!$versions.containsKey($version)) {
                $versions[$version] = @{}
            }
            if ($amd64) {
                $versions[$version]['64'] = $file.url
            } else {
                $versions[$version]['86'] = $file.url
            }
        }
    }

    $latest_version = ''
    $latest_version_info = [Version]::new(0, 0)
    foreach ($version_data in $versions.GetEnumerator()) {
        if ($version_data.Value.Count -ne 2) {
            continue
        }
        $version_data.Name -match $version_re
        $minor = [int]$matches['micro']
        if ($matches['releaselevel'] -eq 'a') {
            $releaselevel = 0
        } elseif ($matches['releaselevel'] -eq 'b') {
            $releaselevel = 1
        } elseif ($matches['releaselevel'] -eq 'rc') {
            $releaselevel = 2
        } else {
            $releaselevel = 3
        }
        if ($matches['serial']) {
            $serial = [int]$matches['serial']
        } else {
            $serial = 0
        }
        $version_info = [Version]::new($minor, $releaselevel, $serial)
        if ($version_info -gt $latest_version_info) {
            $latest_version = $version_data.Name
            $latest_version_info = $version_info
        }
    }

    if (!$latest_version) {
        throw "Can'f find latest version"
    }

    $urls = $versions[$latest_version]
    $latest_version -match $version_re
    $version = "3.10.$($matches['micro'])"
    if ($matches['releaselevel']) {
        $version += "-$($matches['releaselevel'])$($matches['serial'])"
    }
    $zip_name = "python-$latest_version-docs-text"
    $zip_url = "https://docs.python.org/3.10/archives/$zip_name.zip"

    @{
      URL32        = $urls['86']
      URL64        = $urls['64']
      Version      = $version
      ZipName      = $zip_name
      ZipUrl       = $zip_url
    }
}

if ($MyInvocation.InvocationName -ne '.') {
    update -ChecksumFor none
}
