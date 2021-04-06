function Get-GestioFirstFreeNetworkAddress {

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
        $Component = $MyInvocation.MyCommand

        $RequestType = 'firstFreeNetworkAddress'

        $RequestString = Format-UsedParameters -InputObject $PSBoundParameters -Action Get
    }
    
    process {

        $Result = Invoke-GestioIp -RequestType $RequestType -RequestString $RequestString
    }
    
    end {
        return $Result
    }
}