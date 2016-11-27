#TODO: Proxy
function UrlExists($uri) {
    try {
        $webClient =[System.Net.HttpWebRequest] [System.Net.WebRequest]::Create($uri)
        $webClient.Method = "HEAD"
        $webClient.Timeout = 3000
        $webClient.GetResponse()
    }
    catch [System.Net.WebException] {
        return $false;
    }
    return $true;
}

function AddArchivePathToUrl($url) {
    $newUrl = $url
    $lix = $url.LastIndexOf("/")
    if ($lix -ne -1)  {
        $newUrl = $url.SubString(0, $lix) + "/archives" + $url.SubString($lix)
    }
    return $newUrl
}
