function Get-GestioSetting {

    [CmdletBinding()]

    param (

        # What type of setting that will be returned
        [Parameter(
            Position  = 0,
            Mandatory = $true
        )]
        [ValidateSet(
            'Categories',
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
            
            Categories {
                Write-Host "Writing category list to: $CategoryFile" -ForegroundColor Green
                $Result = Invoke-GestioIp -RequestType listCategories
                $Result | Set-Content -Path $CategoryFile
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