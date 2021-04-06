function Sync-GestioSetting {

    [CmdletBinding()]

    param (
        # What setting that will be syncronized
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
    }
    
    process {
        
        switch ($Type) {

            Categories {Get-GestioSetting -Type Categories}
            Sites      {Get-GestioSetting -Type Sites}
        }
    }
    
    end {
        
    }
}
# End function.