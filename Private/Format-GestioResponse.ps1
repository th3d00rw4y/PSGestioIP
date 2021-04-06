function Format-GestioResponse {
    
    [CmdletBinding()]
    
    param (

        # Inputobject
        [Parameter(
            Position  = 0,
            Mandatory = $true
        )]
        [System.Object]
        $InputObject,

        # Requesttype
        [Parameter(
            Position  = 1,
            Mandatory = $true
        )]
        [string]
        $RequestType
    )
    
    begin {

        #Region Class declaration

        class GestioHost {
            [ValidatePattern('\b(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9]))\b')]
            [string] $Ip
            [AllowNull()]
            [string] $Hostname
            [AllowNull()]
            [string] $Site
            [AllowNull()]
            [string] $Type
            [AllowNull()]
            [string] $Comment
            [AllowNull()]
            [string] $Description

            
        
            GestioHost([string] $Object) {
                $this.SetName($Object)
            }
        
            [string]GetName() {
                return "$($this.Ip) $($this.Hostname) $($this.Site) $($this.Type) $($this.Comment) $($this.Description)"
            }

            GestioHost() {}
        
            [void]SetName([string]$Object) {
                $this.Ip          = ($Object -split ',')[0]
                $this.Hostname    = ($Object -split ',')[1]
                $this.Site        = ($Object -split ',')[2]
                $this.Type        = ($Object -split ',')[3]
                $this.Comment     = if ($Object -match '^(?:[^,]*,){4}(.*),[^,]*$') {$Matches.Values | Select-Object -First 1}
                $this.Description = if (($Object -split ',').Count -gt 5) {
                                        $Object.Split(',')[6]
                                    }
                                    else {
                                        $Object.Split(',')[5]
                                    }
            }
            <# [void]SetName([string]$Object) {
                $this.Ip       = ($Object -split ',')[0]
                $this.Hostname = ($Object -split ',')[1]
                $this.Site     = ($Object -split ',')[2]
                $this.Type     = ($Object -split ',')[3]
                $this.Comment  = if (($Object -split ',').Count -gt 5) {
                                    $Object.Split(',')[4]+$Object.Split(',')[5]
                                 }
                                 else {
                                     ($Object -split ',')[4]
                                 }
                $this.Description = if (($Object -split ',').Count -gt 5) {
                                        $Object.Split(',')[6]
                                    }
                                    else {
                                        $Object.Split(',')[5]
                                    }
            } #>
        
            [void]SetName([string]$Ip,[string]$Hostname,[string]$Site,[string]$Type,[string]$Comment,[string]$Description) {
                $this.Ip          = $Ip
                $this.Hostname    = $Hostname
                $this.Site        = $Site
                $this.Type        = $Type
                $this.Comment     = $Comment
                $this.Description = $Description
            }
        }

        class GestioNetwork {
            [ValidatePattern('\b(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9]))\b')]
            [string] $Ip
            [string] $BM
            [string] $Site
            [string] $Category
            [string] $Comment
            [string] $Description

            GestioNetwork([string] $Object) {
                $this.SetName($Object)
            }

            [string]GetName() {
                return "$($this.Ip) $($this.BM) $($this.Site) $($this.Category) $($this.Comment) $($this.Description)"
            }

            GestioNetwork() {}

            [void]SetName([string]$Object) {
                $this.Ip       = ($Object -split '/')[0]
                $this.BM       = (($Object -split '/')[1] -split ',')[0]
                $this.Site     = ($Object -split ',')[1]
                $this.Category = ($Object -split ',')[2]
                $this.Comment  = if (($Object -split ',').Count -gt 5) {
                                    $Object.Split(',')[3]+$Object.Split(',')[4]
                                 }
                                 else {
                                     ($Object -split ',')[3]
                                 }
                $this.Description = if (($Object -split ',').Count -gt 5) {
                                        $Object.Split(',')[5]
                                    }
                                    else {
                                        $Object.Split(',')[4]
                                    }
            }

            [void]SetName([string]$Ip,[string]$BM,[string]$Site,[string]$Category,[string]$Comment,[string]$Description) {
                $this.Ip          = $Ip
                $this.Hostname    = $BM
                $this.Site        = $Site
                $this.Type        = $Category
                $this.Comment     = $Comment
                $this.Description = $Description
            }
        }

        #endRegion Class declaration
        
        $First  = $InputObject.PSObject.Properties.Name | Where-Object {$_ -ne 'error'}
        $Second = $InputObject.$First.PSObject.Properties.Name | Where-Object {$_ -ne 'error'}

        if (-not ($InputObject.$First.$Second.PSObject.Properties.Name.Count -gt 2)) {
            $Third = $InputObject.$First.$Second.PSObject.Properties.Name | Where-Object {$_ -ne 'error'}
        }

        if ($Third) {
            # Write-Host "3"
            $Objects = $InputObject.$First.$Second.$Third
        }
        elseif ($Second) {
            # Write-Host "2"
            $Objects = $InputObject.$First.$Second
        }
        else {
            # Write-Host "1"
            $Objects = $InputObject.$First
        }
    }
    
    process {
        
        switch ($RequestType) {
            createAS {}
            createClient {}
            createHost {
                $Result = foreach ($item in $Objects) {
                    ($Return = $item)
                }
            }
            createNetwork {}
            createVlan {}
            createVlanProvider {}
            deleteAS {}
            deleteClient {}
            deleteHost {
                $Result = foreach ($item in $Objects) {
                    ($Return = $item)
                }
            }
            deleteNetwork {}
            deleteVlan {}
            deleteVlanProvider {}
            firstFreeNetwork {}
            firstFreeNetworkAddress { $Result = $InputObject.firstFreeNetworkAddressResult.Network }
            firstFreeVlan {}
            freeNetworkAddresses { $Result = $InputObject.freeNetworkAddressesResult.Network }
            getCustomNetworkColumnEntry {}
            listCategories {$Result = $Objects | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name}
            listClients {}
            listCustomNetworkColumns {}
            listGlobalConfig {}
            listHosts {
                $Result = foreach ($item in $Objects) {
                    ($Return = $item)
                }
            }
            listNetworks {
                $Result = foreach ($item in $Objects) {
                    ($Return = $item)
                }
            }
            listRanges {}
            listSites {$Result = $Objects | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name}
            listVlanProviders {}
            listVlans {}
            readAS {}
            readClient {}
            readDNSServerGroup {}
            readHost {
                $Result = foreach ($item in $Objects) {
                    ($Return = $item)
                }
            }
            readNetwork {
                $Result = foreach ($item in $Objects) {
                    ($Return = $item)
                }
            }
            readVlan {}
            readVlanProvider {}
            reserveFirstFreeNetworkAddress {}
            runHostDiscoveryDNS {}
            runHostDiscoverySNMP {}
            runNetworkDiscovery {}
            updateAS {}
            updateClient {}
            updateHost {
                $Result = foreach ($item in $Objects) {
                    ($Return = $item)
                }
            }
            updateNetwork {}
            updateVlan {}
            updateVlanProvider {}
            usedNetworkAddresses {}
            version {}
        }
    }
    
    end {
        return $Result
    }
}
# End function.