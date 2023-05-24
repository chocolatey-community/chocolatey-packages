param(
    [string]$ModuleName = 'Selenium'
)
Import-Module AU

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"      = @{
      # Replace the module version on the Save-Module line
      "(?i)(^\s*\-\s*Save\-Module.*\-Version\s+).*" = "`${1}$($Latest.ModuleVersion)"

      # Attempt to remove all existing checksums
      "(?i)(^\s*file\s*name\:).*"         = ""
      "(?i)(^\s*checksum\s*type\:).*"     = ""
      "(?i)(^\s*checksum(32)?\:).*"       = ""

      # We will clean up the blank lines in the afterupdate step
      # This is because this method doesn't support multiline matching

      # Finally, inject the fresh checksums
      "(?i)(^\s*3. The checksums should match the following:)" = "`${1}`n`n$(
        @($Latest.ModuleChecksums.ForEach{
          @(
            "  file name: $($_.Path -replace "^(?<BasePath>.+)\\Selenium\\$($Latest.ModuleVersion)\\")"
            "  checksum type: $($_.Algorithm)"
            "  checksum: $($_.Hash)"
            "`n"
          ) -join "`n"
        }) -join ''
      )"
    }
  }
}

function global:au_BeforeUpdate() {
  # Get an unused directory
  do {
    $TempPath = Join-Path $env:TEMP "$([GUID]::NewGuid())"
  }
  while (Test-Path $TempPath)
  $null = New-Item -Path $TempPath -ItemType Directory

  # Save the module to the directory, and then compress the content into the package tools directory
  Save-Module -Name $ModuleName -RequiredVersion $Latest.ModuleVersion -Path $TempPath

  $ArchiveArgs = @{
    Path             = Join-Path $TempPath "\$ModuleName\$($Latest.ModuleVersion)\*"
    DestinationPath  = Join-Path $PSScriptRoot "\tools\$ModuleName.zip"
    CompressionLevel = "Optimal"
    Force            = $true
  }
  Compress-Archive @ArchiveArgs

  $Latest.ModuleChecksums = Get-ChildItem $ArchiveArgs.Path -Recurse -File | Get-FileHash

  # Clean up the downloaded module
  Remove-Item $TempPath -Recurse -Force -ErrorAction SilentlyContinue
}

function global:au_AfterUpdate {
  # We need to clean up the large blocks of blank space left by the earlier replacements
  (Get-Content $PSScriptRoot\legal\VERIFICATION.txt -Raw) -replace "(\r?\n){5,999}", "`n`n" | Set-Content -Path $PSScriptRoot\legal\VERIFICATION.txt -NoNewline
}

function global:au_GetLatest {
  $Version = (Find-Module -Name $ModuleName).Version.ToString()

  @{
    Version       = $Version
    ModuleVersion = $Version
  }
}

update -ChecksumFor none