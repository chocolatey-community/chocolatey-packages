$resources = @(
    [PSCustomObject]@{
        Name        = 'Chocolatey Package Creation Docs'
        URL         = 'https://docs.chocolatey.org/en-us/guides/create/'
        Description = 'Official guide covering .nuspec authoring, install scripts, and best practices.'
    }
    [PSCustomObject]@{
        Name        = 'regex101'
        URL         = 'https://regex101.com'
        Description = 'Interactive regex builder and debugger. Essential for writing AU update URL/version patterns.'
    }
    [PSCustomObject]@{
        Name        = 'Chocolatey AU (Automatic Updates)'
        URL         = 'https://github.com/chocolatey-community/chocolatey-au'
        Description = 'Framework for keeping packages automatically up to date. Most community packages use this.'
    }
    [PSCustomObject]@{
        Name        = 'JSONPath/Fiddler / Browser DevTools'
        URL         = 'https://www.telerik.com/fiddler'
        Description = 'Inspect HTTP responses from vendor download pages to find stable download URLs and version info.'
    }
    [PSCustomObject]@{
        Name        = 'VirusTotal'
        URL         = 'https://www.virustotal.com'
        Description = 'Scan installer binaries and submit checksums for the Chocolatey moderation review process.'
    }
    [PSCustomObject]@{
        Name        = 'Chocolatey Community Chat (Discord)'
        URL         = 'https://ch0.co/community'
        Description = 'Get help from the community, ask questions, and discuss package maintenance.'
    }
)

Write-Host ''
Write-Host '==========================================================' -ForegroundColor Cyan
Write-Host '   Chocolatey Package Maintenance Toolkit - Installed!    ' -ForegroundColor Cyan
Write-Host '==========================================================' -ForegroundColor Cyan
Write-Host ''
Write-Host 'The following online resources are recommended for package maintainers:' -ForegroundColor Yellow
Write-Host ''

foreach ($resource in $resources) {
    Write-Host "  $($resource.Name)" -ForegroundColor Green
    Write-Host "    URL : $($resource.URL)" -ForegroundColor White
    Write-Host "    Info: $($resource.Description)" -ForegroundColor Gray
    Write-Host ''
}

Write-Host 'Happy packaging!' -ForegroundColor Cyan
Write-Host ''
