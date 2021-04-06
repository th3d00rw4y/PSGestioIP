function Get-DynamicParameter {

    [CmdletBinding()]

    param (
        # What type of parameter that will be returned
        [Parameter(
            Position  = 0,
            Mandatory = $true
        )]
        [ValidateSet(
            'Category',
            'Site'
        )]
        [string[]]
        $Type
    )

    $ParamPosition = 3

    foreach ($string in $Type) {

        if ($string -eq 'Category') {
            $ParamPosition = 3
        }
        elseif ($string -eq 'Site') {
            $ParamPosition = 4
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
        # Generate and set the ValidateSet 
        $arrSet = Get-Content -Path $(Get-Variable "$($string)File").Value
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        # Add the ValidateSet to the attributes collection
        $AttributeCollection.Add($ValidateSetAttribute)
        # Create and return the dynamic parameter
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParamName, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ParamName, $RuntimeParameter)
    }

<#     switch ($Type) {
        
        Category {
            # Set the dynamic parameters' name
            $ParamName_Category = 'Category'
            # Create the collection of attributes
            $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            # Create and set the parameters' attributes
            $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
            $ParameterAttribute.Mandatory = $false
            $ParameterAttribute.Position = 3
            # Add the attributes to the attributes collection
            $AttributeCollection.Add($ParameterAttribute)
            # Create the dictionary 
            $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            # Generate and set the ValidateSet 
            $arrSet = Get-Content -Path $CategoriesFile
            $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
            # Add the ValidateSet to the attributes collection
            $AttributeCollection.Add($ValidateSetAttribute)
            # Create and return the dynamic parameter
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParamName_Category, [string], $AttributeCollection)
            $RuntimeParameterDictionary.Add($ParamName_Category, $RuntimeParameter)
            
        }
        Site {
            # Set the dynamic parameters' name
            $ParamName_Site = 'Site'
            # Create the collection of attributes
            $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            # Create and set the parameters' attributes
            $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
            $ParameterAttribute.Mandatory = $false
            $ParameterAttribute.Position = 4
            # Add the attributes to the attributes collection
            $AttributeCollection.Add($ParameterAttribute) 
            # Create the dictionary
            if (-not ($RuntimeParameterDictionary)) {
                $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            }
            # Generate and set the ValidateSet 
            $arrSet = Get-Content -Path $SitesFile
            $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
            # Add the ValidateSet to the attributes collection
            $AttributeCollection.Add($ValidateSetAttribute)
            # Create and return the dynamic parameter
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParamName_Site, [string], $AttributeCollection)
            $RuntimeParameterDictionary.Add($ParamName_Site, $RuntimeParameter)
        }
    } #>

    return $RuntimeParameterDictionary
}