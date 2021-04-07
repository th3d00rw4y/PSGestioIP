function Get-GestioNetwork {
    <#
    .SYNOPSIS
    Retrieve a network.
    
    .DESCRIPTION
    Utilizing the request type "readNetwork", this function will retrieve information on the network of the Ip address provided.
    
    .PARAMETER Ip
    Ip address of the network. The regex in validate pattern comes from: https://regexr.com/38odc Credit: rocka84
    
    .EXAMPLE
    Get-GestioNetwork -Ip "192.168.1.0"
    This example will return information on the 192.168.1.0 network.
    
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
        $RequestType = 'readNetwork'

        # Sending $PSBoundParameters to get correct request string back.
        $RequestString = Format-UsedParameters -InputObject $PSBoundParameters -Action Get
    }
    
    process {
        # Sends the request type and request string to the Invoke-GestioIp function.
        $Result = Invoke-GestioIP -RequestType $RequestType -RequestString $RequestString
    }
    
    end {
        # Returns the result.
        return $Result
    }
}