# AU Packages Template: https://github.com/majkinetor/au-packages-template

param($Name = $null)

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }

$Options = [ordered]@{
    Timeout    = 100                                        #Connection timeout in seconds
    Threads    = 10                                         #Number of background jobs to use
    Push       = $Env:au_Push -eq 'true'                    #Push to chocolatey
    PluginPath = ''                                         #Path to user plugins

    Report = @{
        Type = 'markdown'                                   #Report type: markdown or text
        Path = "$PSScriptRoot\Update-AUPacakges.md"         #Path where to save the report
        Params= @{                                          #Report parameters:
            Github_UserRepo = $Env:github_user_repo         #  Markdown: shows user info in upper right corner
            NoAppVeyor  = $false                            #  Markdown: do not show AppVeyor build shield
            UserMessage = ''                                #  Markdown, Text: Custom user message to show
        }
    }

    Gist = @{
        Id          = $Env:gist_id                          #Your gist id or leave empty for anonymous
        ApiKey      = $Env:github_api_key                   #Your github api key
        Path        = "$PSScriptRoot\Update-AUPacakges.md"  #List of files to add to gist
    }

    Git = @{
        User     = ''                                       #Git username, leave empty if github api key is used
        Password = $Env:github_api_key                      #Password if username is not empty, otherwise api key
    }

    RunInfo = @{
        Exclude = 'password', 'apikey'                      #Option keys which contain those words will be removed
        Path    = "$PSScriptRoot\update_info.xml"           #Path where to save the run info
    }

    Mail = if ($Env:mail_user) {
            @{
                To          = $Env:mail_user
                Server      = $Env:mail_server
                UserName    = $Env:mail_user
                Password    = $Env:mail_pass
                Port        = $Env:mail_port
                EnableSsl   = $Env:enable_ssl -eq 'true'
                Attachments = "$PSScriptRoot\update_info.xml"
                UserMessage = ''
                SendAlways  = $false                        #Send notifications every time
             }
           } else {}
}

$global:au_Root = "$PSScriptRoot/../automatic"                           #Path to the AU packages
$info = updateall -Name $Name -Options $Options

#Uncomment to fail the build on AppVeyor on any package error
#if ($info.error_count.total) { throw 'Errors during update' }
