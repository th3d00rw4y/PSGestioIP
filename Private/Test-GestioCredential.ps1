function Test-GestioCredential {

    [CmdletBinding()]
    
    param (
        # PS credential object
        [Parameter(
            Mandatory = $true
        )]
        [pscredential]
        $Credential
    )
    
    begin {

        $Component = $MyInvocation.MyCommand

        if (-not ($Credential.UserName)) {
            return $false
            $CredObjectExists = $false
        }
        else {
            $CredObjectExists = $true

            $Server = $(Import-Csv -Path $ModuleRoot\Settings\Settings.csv).Server
        }
    }
    
    process {

        if ($CredObjectExists -eq $true) {
            
            $URL     = "$($Server)?request_type=version&output_type=xml"
            $Headers = @{"Authorization"="Basic $(Get-AuthenticationToken -Credential $Credential)"}
            
            $InvokeParams = @{
                Uri              = $URL
                Header           = $Headers
                ContentType      = "application/xml; charset=utf-8"
                Method           = 'Get'
                DisableKeepAlive = $true
            }

            try {
                $Response = Invoke-RestMethod @InvokeParams -ErrorAction Stop
                $CredObjectValid = $true
            }
            catch {
                $CredObjectValid = $false
            }
            
        }
        
    }
    
    end {

        if (($CredObjectExists -eq $true) -and ($CredObjectValid -eq $true)) {
            
            if ($Response.versionResult.version -like '1.*') {
                return $true
            }
            else {
                return $false
            }
        }
        else {
            return $false
        }
    }
}