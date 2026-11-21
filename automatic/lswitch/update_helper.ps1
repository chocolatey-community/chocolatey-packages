function GetETagIfChanged() {
    param(
        [string]$url
    )

    $existingETag = $null
    $infoPath = "$PSScriptRoot\info"
    if (Test-Path $infoPath) {
        $existingETag = Get-Content $infoPath -Encoding UTF8 | Select-Object -First 1 | ForEach-Object { $_ -split '\|' } | Select-Object -First 1
    }

    $response = Invoke-WebRequest -Uri $url -Method HEAD -UseBasicParsing -ErrorAction SilentlyContinue
    $etag = $response.Headers.ETag

    if ($etag -eq $existingETag) {
        return $null
    }

    return $response
}