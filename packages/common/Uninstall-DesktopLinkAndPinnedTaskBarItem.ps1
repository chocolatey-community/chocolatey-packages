function Uninstall-DesktopLinkAndPinnedTaskBarItem {
	param(
	[string] $packageName
	)

	$desktopLink="${env:USERPROFILE}\Desktop\${packageName}.exe.lnk"
	$pinnedLink="${env:USERPROFILE}\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\${packageName}.lnk"

	if(!$packageName) {
		throw "Missing PackageName input parameter."
		return
	}

	If (Test-Path "$desktopLink") {
		Remove-Item $desktopLink
		'desktoplink removed'
		return 
	}
	
	If (Test-Path "$pinnedLink") {
		Remove-Item $pinnedLink
		'pinnedlink removed'
		return
	}
}