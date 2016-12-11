# Original version © 2010 Microsoft Corporation. Alle Rechte vorbehalten.
# https://gallery.technet.microsoft.com/scriptcenter/ea40c1ef-c856-434b-b8fb-ebd7a76e8d91

Function Get-IniContent {
    <#
    .Synopsis
        Parses the content of the update INI file

    .Description
        Parses the content of the update INI file and returns it as a hashtable

    .Inputs
        System.String

    .Outputs
        System.Collections.Hashtable

    .Parameter FileContent
        Content of the INI file.
    #>

    [CmdletBinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        [Parameter(ValueFromPipeline=$True,Mandatory=$True)]
        [string]$FileContent
    )

    Begin
        {Write-Verbose "$($MyInvocation.MyCommand.Name): Function started"}

    Process
    {
        $ini = @{}

        $FileContent -split "`n" | %{
            switch -regex ($_.Trim()) {
                "^\[([0-9.]+)\]$" # Version
                {
                    $version = $matches[1]
                    $ini[$version] = @{}
                    $CommentCount = 0
                }
                "^(;.*)$" # Comment
                {
                    if (!($version))
                    {
                        $version = "No-Version"
                        $ini[$version] = @{}
                    }
                    $value = $matches[1]
                    $CommentCount = $CommentCount + 1
                    $name = "Comment" + $CommentCount
                    $ini[$version][$name] = $value
                }
                "(.+?)\s*=\s*(.*)" # Key
                {
                    if (!($version))
                    {
                        $version = "No-Version"
                        $ini[$version] = @{}
                    }
                    $name,$value = $matches[1..2]
                    $ini[$version][$name] = $value
                }
            }
        }
        Return $ini
    }

    End
        {Write-Verbose "$($MyInvocation.MyCommand.Name): Function ended"}
}