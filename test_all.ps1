#Name can be 'random N' to randomly force the Nth group of packages.

param( [string[]] $Name, [string] $Root = "$PSScriptRoot\automatic" )

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }
$global:au_root = Resolve-Path $Root

if (($Name.Length -gt 0) -and ($Name[0] -match '^random (.+)')) {
    [array] $lsau = lsau

    $group = [int]$Matches[1]
    $n = (Get-Random -Maximum $group)
    Write-Host "TESTING GROUP $($n+1) of $group"

    $group_size = [int]($lsau.Count / $group) + 1
    $Name = $lsau | select -First $group_size -Skip ($group_size*$n) | % { $_.Name }

    Write-Host ($Name -join ' ')
    Write-Host ('-'*80)
}

$options = [ordered]@{
    Force = $true
    Push = $false

    Report = @{
        Type = 'markdown'                                   #Report type: markdown or text
        Path = "$PSScriptRoot\Update-Force-Test-${n}.md"      #Path where to save the report
        Params= @{                                          #Report parameters:
            Github_UserRepo = $Env:github_user_repo         #  Markdown: shows user info in upper right corner
            NoAppVeyor  = $true                             #  Markdown: do not show AppVeyor build shield
            Title       = "Update Force Test - Group ${n}"
            UserMessage = "[Update report](https://gist.github.com/$Env:gist_id) | [Build](https://ci.appveyor.com/project/chocolatey/chocolatey-coreteampackages-xnxcr) | **USING AU NEXT VERSION**"       #  Markdown, Text: Custom user message to show
        }
    }

    Gist = @{
        Id     = $Env:gist_id_test                          #Your gist id; leave empty for new private or anonymous gist
        ApiKey = $Env:github_api_key                        #Your github api key - if empty anoymous gist is created
        Path   = "$PSScriptRoot\Update-Force-Test-${n}.md"       #List of files to add to the gist
        Description = "Update Force Test Report #powershell #chocolatey"
    }
}


$global:info = updateall -Name $Name -Options $Options
