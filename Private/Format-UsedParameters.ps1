function Format-UsedParameters {

    [CmdletBinding()]

    param (
        # PSBoundParameter object
        [Parameter(
            Position  = 0,
            Mandatory = $false
        )]
        [System.Object]
        $InputObject,

        # Single string input
        [Parameter(
            Position  = 1,
            Mandatory = $false
        )]
        [string]
        $InputString,

        # Decides wheter to use get parameters or set parameters
        [Parameter(
            Position  = 2,
            Mandatory = $true
        )]
        [ValidateSet(
            'Get',
            'Set',
            'List'
        )]
        [string]
        $Action
    )
    
    begin {

        switch ($Action) {
            Get {
                $Ip          = '&ip='
                $Hostname    = '&hostname='
            }
            Set {
                $Ip          = '&ip='
                $Hostname    = '&new_hostname='
                $Description = '&new_descr='
                $Site        = '&new_site='
                $Category    = '&new_cat='
                $int_Admin   = '&new_int_admin='
                $Comment     = '&new_comment='
            }
            List {
                $Hostname    = 'hostname::'
                $Site        = 'site::'
                $Category    = 'category::'
                $Comment     = 'comment::'
                $Description = 'description::'
                $RootNetwork = 'network_type='
            }
        }

        if ($InputObject.Keys -contains 'Wildcard') {
            $WCMatch = $InputObject.Keys | where-object {$_ -in $InputObject['Wildcard']}

            $MatchAll = '[[MATCH_ALL]]'
        }
    }
    
    process {
        
        $RequestStringStarted = $false

        if ($Action -eq 'List') {
            
            switch ($InputObject.Keys) {

                Hostname {
                    
                    if ('Hostname' -in $WCMatch) {
                        $Hostname = "&filter=$Hostname$($InputObject['Hostname'])$MatchAll"
                    }
                    else {
                        $Hostname = "&filter=$Hostname$($InputObject['Hostname'])"
                    }
                    
                    $RequestString = $Hostname
                    $RequestStringStarted = $true
                }

                Category {
                    $Category = "$Category$($InputObject['Category'])"

                    if ($RequestStringStarted -eq $true) {
                        $RequestString += ",$Category"
                    }
                    else {
                        $RequestString = "&filter=$Category"
                        $RequestStringStarted = $true
                    }
                }

                Site {
                    $Site = "$Site$($InputObject['Site'])"

                    if ($RequestStringStarted -eq $true) {
                        $RequestString += ",$Site"
                    }
                    else {
                        $RequestString = "&filter=$Site"
                        $RequestStringStarted = $true
                    }
                }
                
                Comment {

                    if ('Comment' -in $WCMatch) {
                        $Comment = "$Comment$($InputObject['Comment'])$MatchAll"
                    }
                    else {
                        $Comment = "$Comment$($InputObject['Comment'])"
                    }
                    

                    if ($RequestStringStarted -eq $true) {
                        $RequestString += ",$Comment"
                    }
                    else {
                        $RequestString = "&filter=$Comment"
                        $RequestStringStarted = $true
                    }
                }
                Description {

                    if ('Description' -in $WCMatch) {
                        $Description = "$Description$($InputObject['Description'])$MatchAll"
                    }
                    else {
                        $Description = "$Description$($InputObject['Description'])"
                    }
                    
                    if ($RequestStringStarted -eq $true) {
                        $RequestString += ",$Description"
                    }
                    else {   
                        $RequestString = "&filter=$Description"
                        $RequestStringStarted = $true
                    }
                }

                RootNetwork {

                    if ($InputObject['RootNetwork'] -eq $true) {
                        $RootNetwork = "&$($RootNetwork)root"
                    }

                    if ($RequestStringStarted -eq $true) {
                        $RequestString += "$($RootNetwork)$RequestString"
                    }
                    else {
                        $RequestString = $RootNetwork
                        $RequestStringStarted = $true
                    }
                }
            }

            $RequestString = "$RequestString&no_csv=yes"
        }
        elseif ($InputString) {
            $Ip = "$Ip$($InputString)"
            $RequestString = $Ip
        }
        else {
            
            switch ($InputObject.Keys) {
                Ip {
                    $Ip = "$Ip$($InputObject['Ip'])"
                    $RequestString = $Ip
                }
                Hostname {
                    $Hostname = "$Hostname$($InputObject['Hostname'])"
                    $RequestString += $Hostname
                }
                Description {
                    $Description = "$Description$($InputObject['Description'])"
                    $RequestString += $Description
                }
                Site {
                    $Site = "$Site$($InputObject['Site'])"
                    $RequestString += $Site
                }
                Category {
                    $Category = "$Category$($InputObject['Category'])"
                    $RequestString += $Category
                }
                Comment {
                    $Comment = "$Comment$($InputObject['Comment'])"
                    $RequestString += $Comment
                }
            }
        }
    }
    
    end {
        Write-Host $RequestString -ForegroundColor Green
        return $RequestString
    }
}
# End function.