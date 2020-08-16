md ./Error
md ./Results
md ./ToTest
md ./Working
.\Test-Sandbox.ps1 { 
    Set-Service -Name wuauserv -StartupType Manual
    Start-Service wuauserv
    if(!$(choco install -y choco-nuspec-checker)) {
        throw "Install failed"
    }
    choco install -y 7zip
    $files = Get-ChildItem ./ToTest/*.nupkg
    foreach ($file in $files) {
        write-host "Testing $(($file.Name).replace('.nupkg',''))"
        md "./$($file.Name)"
        cd "./$($file.Name)"
        7z.exe x $file
        cd ..
        cnc "./$($file.Name)" > "./Results/cnc.$($file.Name).txt"
        if($(choco install -dy $(($file.Name).replace('.nupkg','')) -s "./ToTest/;https://chocolatey.org")) {
            Write-Host "$(($file.Name).replace('.nupkg','')) working" -ForegroundColor Green
            Move-Item $file ./Working/
        } else {
            Write-Debug "$(($file.Name).replace('.nupkg','')) Not working"
            Move-Item $file ./Error/
            $errors=$true
        }
    }
    if($errors -eq $false) {
        Stop-Computer
    }
}
