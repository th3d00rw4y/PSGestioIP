function Get-GestioHostList {

    <#
    .SYNOPSIS
    Retrieve a list of hosts.
    
    .DESCRIPTION
    Utilizing the request type "listHosts", this function will retrieve a list of hosts matching the search critera entered in the different parameters.
    
    .PARAMETER Hostname
    Search for hosts based on hostname.
    This parameter can be combined together with the Wildcard parameter.
    
    .PARAMETER Comment
    Search for hosts based on comment
    This parameter can be combined together with the Wildcard parameter.
    
    .PARAMETER Description
    Search for hosts based on description
    This parameter can be combined together with the Wildcard parameter.

    .PARAMETER Category
    Choose a host category to streamline your search to only search for hosts in that category.
    A list of current host categories will be populated in validate set upon first import of the module.
    If new host categories are added to GestióIP, they can be synced with the Sync-GestioSetting CMDlet.
    This parameter can be combined together with the Wildcard parameter.

    .PARAMETER Site
    Choose a site to retrieve hosts within that site.
    A list of current sites will be populated in validate set upon first import of the module. 
    If new sites has been added to GestióIP, they can be synced with the Sync-GestioSetting CMDlet.
    This parameter can be combined together with the Wildcard parameter.
    
    .PARAMETER Wildcard
    Accepts either Category, Comment, Description, Hostname or Site.
    Wildcard will add the [[MATCH_ALL]] string after the string entered to one of the above sets.
    
    .EXAMPLE
    Get-GestioHostList -Hostname "Sales_Printer_030"
    This example will return the host with the hostname Sales_Printer_030

    .EXAMPLE
    Get-GestioHostList -Hostname "_Printer" -Wildcard Hostname
    This example will return all hosts that contains the string _Printer

    .EXAMPLE
    Get-GestioHostList -Comment "MyUsername" -Category "Workstation" -Site "Sales" -Wildcard Comment
    This example will return all hosts that has "MyUsername" in the comment column, has the category set to Workstation and is registred to the Sales site.
    
    .NOTES
    Version: 0.0.10
    Author:  Simon Mellergård
    Contact: https://github.com/th3d00rw4y
    #>

    [CmdletBinding()]

    param (
        # Hostname filter
        [Parameter(
            Position  = 0,
            Mandatory = $false
        )]
        [string]
        $Hostname,

        # Comment filter
        [Parameter(
            Position  = 1,
            Mandatory = $false
        )]
        [string]
        $Comment,

        # Description filter
        [Parameter(
            Position  = 2,
            Mandatory = $false
        )]
        [string]
        $Description,

        # Adds a wildcard search to one of the included sets.
        [Parameter(
            Position  = 5,
            Mandatory = $false
        )]
        [ValidateSet(
            'Category',
            'Comment',
            'Description',
            'Hostname',
            'Site'
        )]
        [string[]]
        $Wildcard
    )

    dynamicparam {
        Get-DynamicParameter -Type HostCategory, Site
    }
    
    begin {
        # For logging purposes
        $Component = $MyInvocation.MyCommand

        # What request type that will be sent to Invoke-GestioIp
        $RequestType = 'listHosts'

        # Sending $PSBoundParameters to get correct request string back.
        $RequestString = Format-UsedParameters -InputObject $PSBoundParameters -Action List
    }
    
    process {
        # Sends the request type and request string to the Invoke-GestioIp function.
        $Result = Invoke-GestioIp -RequestType $RequestType -RequestString $RequestString
    }
    
    end {
        # Returns the result.
        return $Result
    }
}
# End function.