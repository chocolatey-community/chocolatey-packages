
function Set-ReadMeFile {
[CmdletBinding()]
param(
    [string]$file = "$pwd\README.tmp",
    [string[]]$keys,
    [string[]]$new_info
)
$me = ( $MyInvocation.MyCommand );

$keys = $keys.split(",")
$new_info = $new_info.split(",")
$data = Get-Content -Path $file; $i=0
foreach( $item in $keys ) {
$data = $data  -replace( "<$item>" , $($new_info[$i]) )
$i++
}

Write-Verbose "$me data -$data-"
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines("$pwd/README.md", $data, $Utf8NoBomEncoding)

}
