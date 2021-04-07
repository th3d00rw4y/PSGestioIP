function Remove-GestioHost {
    <#
    .SYNOPSIS
    Deletes a host

    .DESCRIPTION
    Utilizing the request type "deleteHost", this CMDlet will based on either Ip or Hostname remove a host entry in GestióIP.
    The API documentation says the following:
        
    "IP addresses are unique. Hostnames may not be unique. If there are more than one host with the same 
    hostname found in the database, the first found host will deleted."

    .PARAMETER Ip
    Ip address of the host to be removed. The regex in validate pattern comes from: https://regexr.com/38odc Credit: rocka84

    .PARAMETER Hostname
    Hostname of the host to be removed

    .EXAMPLE
    Remove-GestioHost -Ip "192.168.1.14"
    This example will delete the host assigned to 192.168.1.14

    .EXAMPLE
    Remove-GestioHost -Hostname 'Sales_Printer_030'
    This example will delete the host Sales_Printer_030. Beware that if there are multiple hosts with the same hostname, the first one will be deleted.

    .NOTES
    Version: 0.0.10
    Author:  Simon Mellergård
    Contact: https://github.com/th3d00rw4y
    #>

    [CmdletBinding()]

    param (
        # Deletes host based on Ip address. Use this one in first hand.
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

        # Delete host based on hostname. BEWARE! hostnames are not unique. If multiple hosts have the same hostname, first one found will be deleted.
        [Parameter(
            Position  = 1,
            Mandatory = $false,
            ParameterSetName = 'Hostname'
        )]
        [string]
        $Hostname
    )
    
    begin {
        # For logging purposes
        $Component = $MyInvocation.MyCommand

        # What request type that will be sent to Invoke-GestioIp
        $RequestType = 'deleteHost'

        # Sending $PSBoundParameters to get correct request string back.
        $RequestString = Format-UsedParameters -InputObject $PSBoundParameters -Action Set
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