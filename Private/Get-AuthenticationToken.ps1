function Get-AuthenticationToken() {
	[CmdletBinding()]
	param
	(
		[parameter(Mandatory = $true)]
		[System.Management.Automation.PSCredential]$Credential
	)
	begin {

    }
	process {
		$password = Get-PlainText $Credential.Password;
		$key = [string]::Format("{0}:{1}", $Credential.UserName, $password)
	}
	end {
        return [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($key))
    }
}
# End function.