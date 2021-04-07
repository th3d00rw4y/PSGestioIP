function Update-GestioHost {
    <#
    .SYNOPSIS
    Update a GestióIP host

    .DESCRIPTION
    Utilizing the request type "updateHost". This CMDlet will based on Ip address update a host entry in GestióIP.

    .PARAMETER Ip
    Mandatory parameter. Provided Ip address will be the target for the update.

    .PARAMETER Hostname
    The host targets new name

    .PARAMETER Description
    New description for the host.

    .PARAMETER Category
    The new category for the host.
    A list of current host categories will be populated in validate set upon first import of the module.
    If new host categories are added to GestióIP, they can be synced with the Sync-GestioSetting CMDlet.

    .PARAMETER Site
    The new site for the host.
    A list of current sites will be populated in validate set upon first import of the module. 
    If new sites has been added to GestióIP, they can be synced with the Sync-GestioSetting CMDlet.

    .PARAMETER int_Admin
    -

    .PARAMETER Comment
    New comment for the host. Leaving it blank will enter the string "Updated with powershell module PSGestioIP: yyyy-MM-dd - YourUsername"

    .EXAMPLE
    Update-GestioHost -Ip "192.168.1.14" -Hostname "Sales_Printer_031" -Description "Floor 4" -Category "OneOfYourCategories" -Site "OneOfYourSites"
    This example will update the host rigistered on 192.168.1.14 with hostname "Sales_Printer_031", description "Floor 4", Category "OneOfYourCategories", Site "OneOfYourSites" and Comment "Updated with powershell module PSGestioIP: yyyy-MM-dd - YourUsername"

    .NOTES
    Version: 0.0.10
    Author:  Simon Mellergård
    Contact: https://github.com/th3d00rw4y
    #>

    [CmdletBinding()]

    param (
        # Reserves given ip address.
        [Parameter(
            Position  = 0,
            Mandatory = $true
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

        # 
        [Parameter(
            Position  = 5,
            Mandatory = $false,
            DontShow
        )]
        [ValidateSet(
            'y',
            'n'
        )]
        [string]
        $int_Admin,

        # Please provide a comment for the host, anything will do.
        [Parameter(
            Position  = 6,
            Mandatory = $false
        )]
        [ValidatePattern(
            '^(?:[^,|.|_])*$'
        )]
        [string]
        $Comment = "Updated with powershell module PSGestioIP: $(Get-Date -Format yyyy-MM-dd) - $($env:USERNAME)"
    )

    dynamicparam {
        Get-DynamicParameter -Type HostCategory, Site
    }
    
    begin {
        $Component = $MyInvocation.MyCommand

        $RequestType = 'updateHost'

        if (-not ($PSBoundParameters['Comment'])) {
            $PSBoundParameters.Add('Comment', $Comment)
        }

        # $Global:Ps = $PSBoundParameters

        $RequestString = Format-UsedParameters -InputObject $PSBoundParameters -Action Set
    }
    
    process {
        $Result = Invoke-GestioIp -RequestType $RequestType -RequestString $RequestString
    }
    
    end {
        return $Result
    }
}
# End function.