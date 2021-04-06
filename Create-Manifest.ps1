$ModuleManifest = @{
    Path               = '.\PSGestioIP.psd1'
    RootModule         = '.\PSGestioIP.psm1'
    Author             = 'Simon Mellergård'
    CompanyName        = 'Värnamo kommun, it-avdelningen'
    Copyright          = '2021 Värnamo kommun, it-avdelningen. All rights reserved.'
    ModuleVersion      = '0.0.1.1'
    PowerShellVersion  = '5.1'
    GUID               = 'd0f7579a-073e-436e-893b-ef591d4afea6'
    Description        = 'Wrapper module for integrations with the GestióIP API.'
}

Remove-Item -Path '.\PSGestioIP.psd1'

New-ModuleManifest @ModuleManifest