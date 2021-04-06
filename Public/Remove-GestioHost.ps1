function Remove-GestioHost {

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
        [ValidatePattern(
            '^(?:\S|\r[^å|ä|ö|Å|Ä|Ö|,|.])*$'
        )]
        [string]
        $Hostname
    )
    
    begin {
        $Component = $MyInvocation.MyCommand

        $RequestType = 'deleteHost'

        $RequestString = Format-UsedParameters -InputObject $PSBoundParameters -Action Set
    }
    
    process {
        #Write-Host $RequestString -ForegroundColor Green
        $Result = Invoke-GestioIp -RequestType $RequestType -RequestString $RequestString
    }
    
    end {
        return $Result
    }
}
# End function.