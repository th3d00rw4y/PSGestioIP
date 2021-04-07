﻿function Get-GestioHost {
    <#
    .SYNOPSIS
    Retrieve a host.
    
    .DESCRIPTION
    Utilizing the request type "readHost", this CMDlet will retrieve a host based on either Ip address or hostname.
    
    .PARAMETER Ip
    Ip address of the host. The regex in validate pattern comes from: https://regexr.com/38odc Credit: rocka84
    
    .PARAMETER Hostname
    Hostname to be searched for
    
    .EXAMPLE
    Get-GestioHost -Ip "192.168.1.14"
    This example will retrieve the host that is assigned to 192.168.1.14

    .EXAMPLE
    Get-GestioHost -Hostname "Sales_Printer_003"
    This example will retrieve the host with hostname Sales_Printer_003
    
    .NOTES
    Version: 0.0.10
    Author:  Simon Mellergård
    Contact: https://github.com/th3d00rw4y
    #>

    [CmdletBinding()]

    param (
        # What Ip address will be searched for.
        [Parameter(
            Position  = 0,
            Mandatory = $false,
            ParameterSetName = 'Ip'
        )]
        [ValidatePattern(
            '\b(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9]))\b'
        )]
        [string]
        $Ip,

        # What hostname will be searched for.
        [Parameter(
            Position  = 1,
            Mandatory = $false,
            ParameterSetName = 'Host'
        )]
        [string]
        $Hostname
    )
    
    begin {
        # For logging purposes
        $Component = $MyInvocation.MyCommand

        # What request type that will be sent to Invoke-GestioIp
        $RequestType = 'readHost'

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
# End function.