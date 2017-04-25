$workingDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$updateScript = Join-Path $workingDir 'update.ps1'

& $updateScript

Describe "au_GetLatest Unit Tests" {
  BeforeAll {
    $progressPreference = 'silentlyContinue'
    $stableVersionDownloadUri = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2022.4.24%20Offline%20Installer.exe'
    $stableVersion = '22.4.24'
    $stableVersionResponse = @{
      ResponseUri = @{
        AbsoluteUri = $stableVersionDownloadUri
      }
    }
    $betaVersion = '23.3.15'
    $firstBetaLink = "<a href=""/t5/Desktop-client-builds/Beta-Build-23-3-15/m-p/212932#M3806"" class=""page-link lia-link-navigation lia-custom-event"">Beta Build $($betaVersion)</a>"
    $betaVersionDownloadUri = "https://clientupdates.dropboxstatic.com/client/Dropbox%20$($betaVersion)%20Offline%20Installer.exe"
  }

  Context "When the Stable Version is Requsted" {
    $global:getBetaVersion = $false
    
    Mock Get-WebURL { $stableVersionResponse } -Verifiable

    $versionInfo = au_GetLatest

    It "Should Call the Mocks" {
        Assert-VerifiableMocks
    }

    It "Should Parse the Stable Version" {
        ($versionInfo | Out-String) | Should Be $(@{ URL32 = $stableVersionDownloadUri; Version = $stableVersion } | Out-String)
    }
  }
  Context "When the Beta Version is Requsted" {
    $global:getBetaVersion = $true

    Mock Get-FirstBetaLink { $firstBetaLink } -Verifiable

    $versionInfo = au_GetLatest

    It "Should Call the Mocks" {
        Assert-VerifiableMocks
    }

    It "Should Parse the Beta Version" {
        ($versionInfo | Out-String) | Should Be $(@{ URL32 = $betaVersionDownloadUri; Version = $betaVersion } | Out-String)
    }
  }
  Context "When the Beta Version is Requsted" {
    $global:getBetaVersion = $true

    Mock Get-FirstBetaLink { $firstBetaLink } -Verifiable

    $versionInfo = au_GetLatest

    It "Should Call the Mocks" {
        Assert-VerifiableMocks
    }

    It "Should Parse the Beta Version" {
        ($versionInfo | Out-String) | Should Be $(@{ URL32 = $betaVersionDownloadUri; Version = $betaVersion } | Out-String)
    }
  }
  Context "When the Beta Version is Requsted" {
    $searchReplace = au_SearchReplace

    write-host $searchReplace
    
    It "Should Parse the Beta Version" {
        $true | Should Be $true
    }
  }

  AfterAll {
    $global:getBetaVersion = $false
    $progressPreference = 'continue'
  }
}

Describe "au_GetLatest Integration Tests" {
  BeforeAll {
    $progressPreference = 'silentlyContinue'
    $stableVersionDownloadUri = "https://clientupdates.dropboxstatic.com/client/Dropbox%20$($stableVersion)%20Offline%20Installer.exe"
    $betaVersionDownloadUri = "https://clientupdates.dropboxstatic.com/client/Dropbox%20$($betaVersion)%20Offline%20Installer.exe"
  }

  Context "When the Stable Version is Requsted" {
    $global:getBetaVersion = $false
    $installerFileNameRegEx = $global:stableVersionRegEx
    
    $versionInfo = au_GetLatest
    $stableVersion = $versionInfo.Version
    $expectedUrl = $ExecutionContext.InvokeCommand.ExpandString($stableVersionDownloadUri)

    It "Url and Version Should Be Valid" {
        $versionInfo.URL32 | Should Be $expectedUrl
        $versionInfo.URL32 | Should Match $installerFileNameRegEx
    }
  }
  Context "When the Beta Version is Requsted" {
    $global:getBetaVersion = $true

    $versionInfo = au_GetLatest
    $betaVersion = $versionInfo.Version
    $expectedUrl = $ExecutionContext.InvokeCommand.ExpandString($betaVersionDownloadUri)

    It "Url and Version Should Be Valid" {
        $versionInfo.URL32 | Should Be $expectedUrl
        $versionInfo.URL32 | Should Match $installerFileNameRegEx
    }

    $global:getBetaVersion = $false
  }

  AfterAll {
    $progressPreference = 'continue'
  }
}
