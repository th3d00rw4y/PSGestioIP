function Get-DynamicParameter {

    [CmdletBinding()]

    param (
        # What type of parameter that will be returned
        [Parameter(
            Position  = 0,
            Mandatory = $true
        )]
        [ValidateSet(
            'HostCategory',
            'NetworkCategory',
            'Site'
        )]
        [string[]]
        $Type
    )

    foreach ($string in $Type) {

        switch ($Type) {
            HostCategory    {
                $ParamPosition = 3
                # Generate and set the ValidateSet 
                $arrSet = Get-Content -Encoding UTF8 -Path $(Get-Variable "$($string)File").Value
                $string = $string.Replace('Host', '')
            }
            NetworkCategory {
                $ParamPosition = 3
                # Generate and set the ValidateSet 
                $arrSet = Get-Content -Encoding UTF8 -Path $(Get-Variable "$($string)File").Value
                $string = $string.Replace('Network', '')
            }
            Site {
                $ParamPosition = 4
            }
        }
        
        # Set the dynamic parameters' name
        $ParamName = $string
        # Create the collection of attributes
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        # Create and set the parameters' attributes
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $false
        $ParameterAttribute.Position = $ParamPosition
        # Add the attributes to the attributes collection
        $AttributeCollection.Add($ParameterAttribute)
        # Create the dictionary 
        if (-not ($RuntimeParameterDictionary)) {
            $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        }
        
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        # Add the ValidateSet to the attributes collection
        $AttributeCollection.Add($ValidateSetAttribute)
        # Create and return the dynamic parameter
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParamName, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ParamName, $RuntimeParameter)
    }

    return $RuntimeParameterDictionary
}