function Sync-GestioCategory {
    <#
    .SYNOPSIS
    Synchronize GestióIP categories

    .DESCRIPTION
    Synchronizes either Host, Network or Site categories. Or all of them.
    Categories will be stored in .txt files in $env:TEMP
    The categories will be used to populate category validation sets in the modules CMDlets

    .PARAMETER Type
    What type of category that will be synchronized. 

    .EXAMPLE
    Sync-GestioCategory -Type HostCategories
    This example will retrieve all host categories from GestióIP and store them in a .txt file under $env:TEMP

    .EXAMPLE
    Sync-GestioCategory -Type NetworkCategories, Sites
    This example will retrieve all network and site categories and store them in separate .txt files under $env:TEMP

    .NOTES
    Version: 0.0.10
    Author:  Simon Mellergård
    Contact: https://github.com/th3d00rw4y
    #>

    [CmdletBinding()]

    param (
        # What setting that will be synchronized
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
        # For logging purposes
        $Component = $MyInvocation.MyCommand
    }
    
    process {
        
        # Retrieve the category type
        switch ($Type) {
            HostCategories    {Get-GestioCategory -Type HostCategories}
            NetworkCategories {Get-GestioCategory -Type NetworkCategories}
            Sites             {Get-GestioCategory -Type Sites}
        }
    }
    
    end {
        
    }
}
# End function.