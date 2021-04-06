function Invoke-GestioIp {
    
    [CmdletBinding()]
    
    param (
    
        # Sets the request type for the API call.
        [Parameter(
            Position  = 0,
            Mandatory = $true
        )]
        [ValidateSet(
            'createAS',
            'createClient',
            'createHost',
            'createNetwork',
            'createVlan',
            'createVlanProvider',
            'deleteAS',
            'deleteClient',
            'deleteHost',
            'deleteNetwork',
            'deleteVlan',
            'deleteVlanProvider',
            'firstFreeNetwork',
            'firstFreeNetworkAddress',
            'firstFreeVlan',
            'freeNetworkAddresses',
            'getCustomNetworkColumnEntry',
            'listCategories',
            'listClients',
            'listCustomNetworkColumns',
            'listGlobalConfig',
            'listHosts',
            'listNetworks',
            'listRanges',
            'listSites',
            'listVlanProviders',
            'listVlans',
            'readAS',
            'readClient',
            'readDNSServerGroup',
            'readHost',
            'readNetwork',
            'readVlan',
            'readVlanProvider',
            'reserveFirstFreeNetworkAddress',
            'runHostDiscoveryDNS',
            'runHostDiscoverySNMP',
            'runNetworkDiscovery',
            'updateAS',
            'updateClient',
            'updateHost',
            'updateNetwork',
            'updateVlan',
            'updateVlanProvider',
            'usedNetworkAddresses',
            'version'
        )]
        [string]
        $RequestType,

        # Decides if help function will be called
        [Parameter(
            Position  = 1,
            Mandatory = $false
        )]
        [switch]
        $Help,

        # Select either JSON or XML for output type
        [Parameter(
            Position  = 2,
            Mandatory = $false,
            DontShow
        )]
        [ValidateSet(
            'json',
            'xml'
        )]
        [string]
        $OutputType = $(Import-Csv -Path $ModuleRoot\Settings\Settings.csv).OutputType,

        # Server url
        [Parameter(
            Position  = 3,
            Mandatory = $false,
            DontShow
        )]
        [string]
        $Server = $(Import-Csv -Path $ModuleRoot\Settings\Settings.csv).Server,

        # Sets the username to be used
        [Parameter(
            Position  = 4,
            Mandatory = $false,
            DontShow
        )]
        [string]
        $User = $(Import-Csv -Path $ModuleRoot\Settings\Settings.csv).User,

        # Sets the client to be used
        [Parameter(
            Position  = 5,
            Mandatory = $false,
            DontShow
        )]
        [string]
        $Client = $(Import-Csv -Path $ModuleRoot\Settings\Settings.csv).Client,

        # Request string 
        [Parameter(
            Position  = 6,
            Mandatory = $false
        )]
        [string]
        $RequestString
    )
    
    begin {

        #Region Variable declaration

        # This following regex is copied from https://regexr.com/38odc and will only approve valid ip-addresses.


        # This following regex is copied from https://regex101.com/r/7Y455j/1 and will match everything inbetween the 4th and last comma, sometimes including commas.


        if ($Help -eq $true) {
            $RequestType = "$($RequestType)Help"
        }

        $Request = "?request_type=$RequestType&client_name=$Client$RequestString&output_type=$OutputType"

        #Write-Host $Request -ForegroundColor Green
        
        $URL     = "http://alipam01/gestioip/api/api.cgi$Request"
        $Headers = @{"Authorization"="Basic $(Get-AuthenticationToken -Credential $(Get-GestioCredential))"}
        
        $InvokeParams = @{
            Uri              = $URL
            Header           = $Headers
            ContentType      = "application/$OutputType; charset=utf-8"
            Method           = 'Get'
            DisableKeepAlive = $true
        }
        
        #endRegion Variable declaration
    }
    
    process {
        $Response = Invoke-RestMethod @InvokeParams

        $Result = Format-GestioResponse -InputObject $Response -RequestType $RequestType
    }
    
    end {
        return $Result
    }
}
# End function.
