function Get-GestioNetworkList {
    <#
    .SYNOPSIS
    Retrieve a list of networks.
    
    .DESCRIPTION
    Utilizing the request type "listNetworks", this CMDlet will retrieve a list of networks matching the search critera entered in the different parameters.
    
    .PARAMETER Comment
    Search for networks based on comment
    This parameter can be combined together with the Wildcard parameter.
    
    .PARAMETER Description
    Search for networks based on description
    This parameter can be combined together with the Wildcard parameter.

    .PARAMETER Category
    Choose a network category to streamline your search to only search for hosts in that category.
    A list of current network categories will be populated in validate set upon first import of the module. 
    If new network categories are added to GestióIP, they can be synced with the Sync-GestioSetting CMDlet.

    .PARAMETER Site
    Choose a site to retrieve hosts within that site.
    A list of current sites will be populated in validate set upon first import of the module. 
    If new sites has been added to GestióIP, they can be synced with the Sync-GestioSetting CMDlet.

    .PARAMETER Wildcard
    Accepts either Category, Comment, Description or Site.
    Wildcard will add the [[MATCH_ALL]] string after the string entered to one of the above sets.

    .PARAMETER RootNetwork
    Will return only root networks

    .EXAMPLE
    Get-GestioNetworkList -Site "Sales"
    This example will return all networks that belong to the site Sales.

    .EXAMPLE
    Get-GestioNetworkList -Description "Sales" -Comment "MyUsername" -Wildcard Comment
    This example will return all the networks with the description Sales and has "MyUsername" in the comment column.

    .EXAMPLE
    Get-GestioNetworkList -Description "01" -Wildcard Description
    This example will return all networks that has "01" in the description column.

    .NOTES
    Version: 0.0.10
    Author:  Simon Mellergård
    Contact: https://github.com/th3d00rw4y
    #>

    [CmdletBinding()]

    param (

        # Comment filter
        [Parameter(
            Position  = 0,
            Mandatory = $false
        )]
        [string]
        $Comment,

        # Description filter
        [Parameter(
            Position  = 1,
            Mandatory = $false
        )]
        [string]
        $Description,

        # Provided filters will be matching substrings.
        [Parameter(
            Position  = 2,
            Mandatory = $false
        )]
        [ValidateSet(
            # 'NetworkCategory',
            'Comment',
            'Description',
            'Site'
        )]
        [string[]]
        $Wildcard,

        # If true, root networks will be returned.
        [Parameter(
            Position  = 5,
            Mandatory = $false
        )]
        [switch]
        $RootNetwork
    )

    dynamicparam {
        Get-DynamicParameter -Type NetworkCategory, Site
    }
    
    begin {
        # For logging purposes
        $Component = $MyInvocation.MyCommand

        # What request type that will be sent to Invoke-GestioIp
        $RequestType = 'listNetworks'

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