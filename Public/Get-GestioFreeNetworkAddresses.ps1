function Get-GestioFreeNetworkAddresses {

    <#
    .SYNOPSIS
    Retrieves all free addresses from a network
    
    .DESCRIPTION
    Utilizing the request type "freeNetworkAddresses", This function will retrieve all the free addresses from supplied network address
    
    .PARAMETER Ip
    Ip address of target network. The regex in validate pattern comes from: https://regexr.com/38odc Credit: rocka84
    
    .EXAMPLE
    Get-GestioFreeNetworkAddresses -Ip "192.168.1.0" 
    This example will return all free addresses from within the 192.168.1.0 network.
    
    .NOTES
    Version: 0.0.10
    Author:  Simon Mellergård
    Contact: https://github.com/th3d00rw4y
    #>

    [CmdletBinding()]

    param (

        # Ip address that will be searched for.
        [Parameter(
            Position  = 0,
            Mandatory = $true
        )]
        [ValidatePattern(
            '\b(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9]))\b'
        )]
        [string]
        $Ip
    )
    
    begin {
        # For logging purposes
        $Component = $MyInvocation.MyCommand

        # What request type that will be sent to Invoke-GestioIp
        $RequestType = 'freeNetworkAddresses'

        # Sending $PSBoundParameters to get correct request string back.
        $RequestString = Format-UsedParameters -InputObject $PSBoundParameters -Action Get
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