import-module au

$releases = 'https://www.bleachbit.org/download/windows'

function global:au_GetLatest {
   $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
   $filename = ($download_page.links | Where-Object href -match '.exe$' | 
                  Select-Object -First 1 -expand href) -Replace '.*file=', ''
   $version = $filename -split '-' | Select-Object -First 1 -Skip 1

   # figure out if this is a beta release or a normal release.
   $BetasPage = Invoke-WebRequest -UseBasicParsing "https://download.bleachbit.org/beta"
   $IsBeta = $BetasPage.links | Where-Object {$_.innertext -eq "$version/"}

   if ($IsBeta) {
      $filename = "beta/$version/$filename"
      $version = $version + "-beta"
   }

   @{
      Version = $version
      URL32   = "https://download.bleachbit.org/$filename"
   }
}

function global:au_SearchReplace {
   @{
      ".\legal\VERIFICATION.txt"      = @{
         "(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
         "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
         "(?i)(type:).*"       = "`${1} $($Latest.ChecksumType32)"
      }
   }
}

# A few things should only be done if the script is run directly (i.e. not "dot sourced")
#   (It is dot sourced in the meta-package.)
if ($MyInvocation.InvocationName -ne '.') { 
   function global:au_BeforeUpdate() { 
   Write-host "Downloading BleachBit $($Latest.Version)"
      Get-RemoteFiles -Purge -NoSuffix 
   }

   update -ChecksumFor none
   if ($global:au_old_force -is [bool]) { $global:au_force = $global:au_old_force }
}
