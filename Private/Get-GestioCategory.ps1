function Get-GestioCategory {

    [CmdletBinding()]

    param (

        # What type of setting that will be returned
        [Parameter(
            Position  = 0,
            Mandatory = $true
        )]
        [ValidateSet(
            'HostCategories',
            'NetworkCategories',
            'Sites'
        )]
        [string[]]
        $Type
    )
    
    begin {
        $Component = $MyInvocation.MyCommand

        
        Write-Host $CategoryFile -ForegroundColor Green
    }
    
    process {
        
        switch ($Type) {
            
            HostCategories {
                Write-Host "Writing host category list to: $HostCategoryFile" -ForegroundColor Green
                $Result = Invoke-GestioIp -RequestType listCategories -CategoryType host
                $Result | Set-Content -Path $HostCategoryFile
            }
            NetworkCategories {
                Write-Host "Writing network category list to: $NetworkCategoryFile" -ForegroundColor Green
                $Result = Invoke-GestioIp -RequestType listCategories -CategoryType network
                $Result | Set-Content -Path $NetworkCategoryFile
            }
            Sites {
                Write-Host "Writing site list to: $SiteFile" -ForegroundColor Green
                $Result = Invoke-GestioIp -RequestType listSites
                $Result | Set-Content -Path $SiteFile
            }
        }
    }
    
    end {
        
    }
}