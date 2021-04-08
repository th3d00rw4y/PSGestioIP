function Add-GestioHost {

    <#
    .SYNOPSIS
    Add a host to GestióIP

    .DESCRIPTION
    Utilizing the request type 'createHost', this function will create a host on the supplied Ip togehter with a hostname.

    .PARAMETER Ip
    Ip address that will be reserved for the host. The regex in validate pattern comes from: https://regexr.com/38odc Credit: rocka84

    .PARAMETER Hostname
    Name of the host. Cannot contain whitespace, å-ö, commas or dots.

    .PARAMETER Description
    A description of the host is always good pratice to provide.

    .PARAMETER Category
    Decides what category the new host will be given.
    A list of current categories will be populated in validate set upon first import of the module. 
    If new categories has been added to GestióIP, they can be synced with the Sync-GestioCategory function.

    .PARAMETER Site
    Decides what site the new host will be assigned to.
    A list of current sites will be populated in validate set upon first import of the module. 
    If new sites has been added to GestióIP, they can be synced with the Sync-GestioCategory function.

    .PARAMETER int_Admin
    Switch

    .PARAMETER Comment
    Is preconfigured to enter: "Added with powershell module PSGestioIP: $(Get-Date -Format yyyy-MM-dd) - $($env:USERNAME)"

    .EXAMPLE
    Add-GestioHost -Ip 192.168.1.14 -Hostname "Sales_Printer023" -Description "Floor 3"
    This example will add the host with Ip address 192.168.1.14, Hostname Sales_Printer023, Description Floor 3 and Comment Added with powershell module PSGestioIP: 2021-04-07 - MyUsername"

    .NOTES
    Version: 0.0.10
    Author:  Simon Mellergård
    Contact: https://github.com/th3d00rw4y
    #>

    [CmdletBinding(SupportsShouldProcess = $true)]

    param (
        # Reserves given ip address.
        [Parameter(
            Position  = 0,
            Mandatory = $false
        )]
        [ValidatePattern(
            '\b(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9]))\b'
        )]
        [string]
        $Ip,

        # Sets the new hosts name
        [Parameter(
            Position  = 1,
            Mandatory = $true
        )]
        [ValidatePattern(
            '^(?:\S|\r[^å|ä|ö|Å|Ä|Ö|,|.])*$'
        )]
        [string]
        $Hostname,

        # Add provided description to the host
        [Parameter(
            Position  = 2,
            Mandatory = $false
        )]
        [ValidatePattern(
            '^(?:[^,|.|_])*$'
        )]
        [string]
        $Description,

        # ???????
        [Parameter(
            Position  = 5,
            Mandatory = $false
        )]
        [ValidateSet(
            'y',
            'n'
        )]
        [string]
        $int_Admin,

        # Please provide a comment for the host, anything will do.. or leave it blank to auto populate the field.
        [Parameter(
            Position  = 6,
            Mandatory = $false
        )]
        [ValidatePattern(
            '^(?:[^,|.|_])*$'
        )]
        [string]
        $Comment = "Added with powershell module PSGestioIP: $(Get-Date -Format yyyy-MM-dd) - $($env:USERNAME)"
    )

    # Fetching Category and Site parameters with validate set based on information in GestióIP
    dynamicparam {
        Get-DynamicParameter -Type HostCategory, Site
    }
    
    begin {
        # For logging purposes
        $Component = $MyInvocation.MyCommand

        # What request type that will be sent to Invoke-GestioIp
        $RequestType = 'createHost'

        # If no comment has been supplied, the default one will be added.
        if (-not ($PSBoundParameters['Comment'])) {
            $PSBoundParameters.Add('Comment', $Comment)
        }

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