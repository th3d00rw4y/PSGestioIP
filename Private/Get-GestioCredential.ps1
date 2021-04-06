function Get-GestioCredential {
    
    [CmdletBinding()]

    param (
        [Parameter(Mandatory = $false)]
        [string]$Path = "$env:TEMP\63571053cr37.xml"
    )

    begin {

        $Component = $MyInvocation.MyCommand

        # Variable to tell if files have been found or not.
        $FileFound = Test-Path $Path
    }
    
    process {

        if ($FileFound -eq $true) {
            $Credential = Import-Clixml -Path $Path
        }
        elseif ($FileFound -eq $false) {
            Write-Host "Credential object not found!" -ForegroundColor Red
        }
    }

    end {
        return $Credential
    }
}
# End function.