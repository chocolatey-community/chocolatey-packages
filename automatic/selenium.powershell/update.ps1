param(
    [string]$ModuleName = 'Selenium'
)
Import-Module Chocolatey-AU

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      # Replace the module version on the Save-Module line
      "(?i)(-RequiredVersion\s+).*" = "`${1}$($Latest.ModuleVersion)"
      "(?i)(Selenium\\).*``" = "`${1}$($Latest.ModuleVersion)``"
    }
  }
}

function global:au_BeforeUpdate() {
  # Get an unused directory
  do {
    $tempPath = Join-Path $env:TEMP "$([GUID]::NewGuid())"
  }
  while (Test-Path $tempPath)
  $null = New-Item -Path $tempPath -ItemType Directory

  # Save the module to the directory, and then compress the content into the package tools directory
  Save-Module -Name $ModuleName -RequiredVersion $Latest.ModuleVersion -Path $tempPath

  $archiveArgs = @{
    Path             = Join-Path $tempPath "\$ModuleName\$($Latest.ModuleVersion)\*"
    DestinationPath  = Join-Path $PSScriptRoot "\tools\$ModuleName.zip"
    CompressionLevel = "Optimal"
    Force            = $true
  }
  Compress-Archive @archiveArgs

  $Latest.ModuleChecksums = Get-ChildItem $archiveArgs.Path -Recurse -File | Get-FileHash

  # Clean up the downloaded module
  Remove-Item $tempPath -Recurse -Force -ErrorAction SilentlyContinue
}

function global:au_AfterUpdate {
  $verificationFile = "$PSScriptRoot\legal\VERIFICATION.txt"
  (Get-Content $verificationFile | Select-Object -First 16) | Set-Content -Path $verificationFile
  @($Latest.ModuleChecksums.ForEach{
    @(
      "  file name: $($_.Path -replace "^(?<BasePath>.+)\\Selenium\\$($Latest.ModuleVersion)\\")"
      "  checksum type: $($_.Algorithm)"
      "  checksum: $($_.Hash)"
      "`n"
    ) -join "`n"
  }) -join '' | Add-Content -Path $verificationFile -NoNewline
}

function global:au_GetLatest {
  $version = (Find-Module -Name $ModuleName).Version.ToString()

  @{
    Version       = $version
    ModuleVersion = $version
  }
}

update -ChecksumFor none
