$arm64 = $env:PROCESSOR_ARCHITEW6432 -eq 'ARM64'
$url = if ($arm64) { 'https://github.com/zfogg/ascii-chat/releases/download/v0.16.30/libasciichat-0.16.30-Windows-arm64.zip' } else { 'https://github.com/zfogg/ascii-chat/releases/download/v0.16.30/libasciichat-0.16.30-Windows-amd64.zip' }
$hash = if ($arm64) { '9E1839CA708EC1BCB23B74094B65D5593DE15E3BCF952C604A746BB6BEDF3FB0' } else { '8894B6EBDFAA0201851AB5432818B97A6D3025F3E510678B496864417E505B17' }
Install-ChocolateyZipPackage -PackageName 'libasciichat' -Url $url -UnzipLocation (Join-Path (Get-ToolsLocation) 'libasciichat') -Checksum $hash -ChecksumType 'sha256'
