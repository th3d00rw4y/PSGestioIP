$Script:ModuleRoot          = $PSScriptRoot
$Script:CredentialFile      = "$env:TEMP\63571053cr37.xml"
$Script:HostCategoryFile    = "$env:TEMP\GestioHostCategories.txt"
$Script:NetworkCategoryFile = "$env:TEMP\GestioNetworkCategories.txt"
$Script:SiteFile            = "$env:TEMP\GestioSites.txt"

$Private = @(Get-ChildItem -Path $ModuleRoot\Private\*.ps1 -ErrorAction SilentlyContinue)
$Public  = @(Get-ChildItem -Path $ModuleRoot\Public\*.ps1 -ErrorAction SilentlyContinue)

foreach ($Import in @($Private + $Public)) {
    try {
        . $Import.FullName
    }
    catch {
        Write-Error -Message "Failed to import function $($Import.FullName): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
Export-ModuleMember -Variable ModuleRoot, HostCategoryFile, NetworkCategoryFile, SiteFile

if (-not (Test-Path $CredentialFile)) {
    Clear-Host
    Save-GestioCredential -User 'gipadmin'
}

if ($false -in (Test-Path $HostCategoryFile, $NetworkCategoryFile, $SiteFile)) {
    Get-GestioCategory -Type HostCategories, NetworkCategories, Sites
}