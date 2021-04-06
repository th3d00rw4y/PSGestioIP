function Update-GestioHost {

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