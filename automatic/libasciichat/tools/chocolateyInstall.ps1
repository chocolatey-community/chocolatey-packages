$arm64 = $env:PROCESSOR_ARCHITEW6432 -eq 'ARM64'
$url = if ($arm64) { 'https://github.com/zfogg/ascii-chat/releases/download/v0.16.113/libasciichat-0.16.113-Windows-arm64.zip' } else { 'https://github.com/zfogg/ascii-chat/releases/download/v0.16.113/libasciichat-0.16.113-Windows-amd64.zip' }
$hash = if ($arm64) { '59A04CE683E5CCBE21EC39976D23FD7391B0FE0FD04A76D4B7346557721DCE9A' } else { '55299E3E6CDE8F6C08BE6C9630BFE8BD14D7A9C11CE413532844596F4E65A71D' }
Install-ChocolateyZipPackage -PackageName 'libasciichat' -Url $url -UnzipLocation (Join-Path (Get-ToolsLocation) 'libasciichat') -Checksum $hash -ChecksumType 'sha256'
