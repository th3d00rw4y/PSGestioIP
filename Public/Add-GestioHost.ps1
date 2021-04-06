function Add-GestioHost {
    <#
    .SYNOPSIS
    Short description
    
    .DESCRIPTION
    Long description
    
    .PARAMETER Ip
    Parameter description
    
    .PARAMETER Hostname
    Sets the name for the host. Given name will be validated thru the following regex:
        ^\S - fail if provided string contains a whitespace
        [^å|ä|ö|Å|Ä|Ö|,|.] - will fail if any of the characters exists in provided string
        *$ - match everything else.
    
    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>

    [CmdletBinding()]

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

        # Please provide a comment for the host, anything will do.
        [Parameter(
            Position  = 6,
            Mandatory = $false
        )]
        [ValidatePattern(
            '^(?:[^,|.|_])*$'
        )]
        [string]
        $Comment = "Added with Gestio powershell module: $(Get-Date -Format yyyy-MM-dd) - $($env:USERNAME)"
    )

    dynamicparam {
        Get-DynamicParameter -Type Category, Site
    }
    
    begin {
        
        $Component = $MyInvocation.MyCommand

        $RequestType = 'createHost'

        if (-not ($PSBoundParameters['Comment'])) {
            $PSBoundParameters.Add('Comment', $Comment)
        }

        # $Global:Ps = $PSBoundParameters

        $RequestString = Format-UsedParameters -InputObject $PSBoundParameters -Action Set

        Write-Host $RequestString -ForegroundColor Yellow
    }
    
    process {
        $Result = Invoke-GestioIp -RequestType $RequestType -RequestString $RequestString
    }
    
    end {
        return $Result
    }
}
# End function.