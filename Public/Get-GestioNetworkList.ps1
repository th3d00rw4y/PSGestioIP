function Get-GestioNetworkList {

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
            'Hostname',
            'Comment',
            'Description'
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
        Get-DynamicParameter -Type Category, Site
    }
    
    begin {
        $Component = $MyInvocation.MyCommand

        $RequestType = 'listNetworks'

        $RequestString = Format-UsedParameters -InputObject $PSBoundParameters -Action List
    }
    
    process {
        $Result = Invoke-GestioIp -RequestType $RequestType -RequestString $RequestString
    }
    
    end {
        return $Result
    }
}