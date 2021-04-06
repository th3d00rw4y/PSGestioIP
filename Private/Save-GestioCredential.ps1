function Save-GestioCredential {

    [CmdletBinding()]
    
    param (
        
        # Name of the user to be assigned with the stored credential
        [Parameter(
            Position  = 0,
            Mandatory = $true
        )]
        [string]
        $User
    )
    
    begin {
        $Component = $MyInvocation.MyCommand

        $Credential = Get-Credential -Message "This is a one time action to securely store the gestio credential bound to $($env:COMPUTERNAME)\$($env:USERNAME)" -UserName $User
        
    }
    
    process {

        if ((Test-GestioCredential -Credential $Credential) -eq $false) {
            
            do {
                Clear-Host
                $Credential = Get-Credential -Message "Wrong password entered. Please provide correct password." -UserName $User
            }
            until ((Test-GestioCredential -Credential $Credential) -eq $true)
        }
        
        $Credential | Export-Clixml -Path $CredentialFile

        Write-Host "Successfully stored credentials for $($env:COMPUTERNAME)\$($env:USERNAME) !" -ForegroundColor Green
    }
    
    end {
        Remove-Variable Credential
    }
}
# End function.