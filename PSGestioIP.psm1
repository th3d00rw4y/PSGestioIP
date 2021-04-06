$Script:ModuleRoot     = $PSScriptRoot
$Script:CredentialFile = "$env:TEMP\63571053cr37.xml"
$Script:CategoryFile   = "$env:TEMP\GestioCategories.txt"
$Script:SiteFile       = "$env:TEMP\GestioSites.txt"

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
Export-ModuleMember -Variable ModuleRoot, CategoryFile, SiteFile

if (-not (Test-Path $CredentialFile)) {
    Clear-Host
    Save-GestioCredential -User 'gipadmin'
}

if ($false -in (Test-Path $CategoryFile, $SiteFile)) {
    Get-GestioSetting -Type Categories, Sites
}