$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

$TargetFileName = "notepad"
$TargetFile = "$env:SystemRoot\System32\${TargetFileName}.exe"

. $env:ChocolateyInstall\helpers\functions\Install-ChocolateyDesktopLink.ps1
. $env:ChocolateyInstall\helpers\functions\Install-ChocolateyPinnedTaskBarItem.ps1

Install-ChocolateyDesktopLink "${TargetFile}"
Install-ChocolateyPinnedTaskBarItem "${TargetFile}"

Describe "Uninstall-DesktopLinkAndPinnedTaskBarItem" {
	Context "When createServiceCommand parameter is passed to this function and is invalid" {
		It "should return an error" {
			{ Uninstall-DesktopLinkAndPinnedTaskBarItem } | Should throw "Missing PackageName input parameter."
		}
	}

	Context "test that desktop link will be removed" {
		$uninstallDesktopLink = Uninstall-DesktopLinkAndPinnedTaskBarItem -packageName "$TargetFileName"

		It "should match the string" {
			$uninstallDesktopLink  | Should Be 'desktoplink removed'
		}		
	}
	
	Context "test that PinnedTaskBarItem will be removed" {
		$uninstallPinnedTaskBarItem = Uninstall-DesktopLinkAndPinnedTaskBarItem -packageName "$TargetFileName"

		It "should match the string" {
			$uninstallPinnedTaskBarItem  | Should Be 'pinnedlink removed'
		}		
	}	
}