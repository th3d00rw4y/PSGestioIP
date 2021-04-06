function Get-GestioHost {
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
        
        $Component = $MyInvocation.MyCommand

        $RequestType = 'readHost'

        <# if ($Ip) {
            
            $InvokeParams = @{
                Ip          = $Ip
                RequestType = $RequestType
            }
        }
        elseif ($Hostname) {
            
            $InvokeParams = @{
                Hostname    = $Hostname
                RequestType = $RequestType
            }
        } #>

        $RequestString = Format-UsedParameters -InputObject $PSBoundParameters -Action Get
    }
    
    process {

        $Result = Invoke-GestioIp -RequestType $RequestType -RequestString $RequestString
    }
    
    end {
        return $Result
    }
}
# End function.