$versionUnderscore = '{{PackageVersion}}' -replace '\.', '_'
# DownloadUrlx64 gets “misused” here to retrieve the correct folder from sourceforge

Install-ChocolateyPackage '{{PackageName}}' 'exe' '/S' "http://sourceforge.net/projects/sauerbraten/files/sauerbraten/{{DownloadUrlx64}}/sauerbraten_${versionUnderscore}_collect_edition_windows.exe/download"